# Load data
data <- Original_training_DB_e1_positive

# Check structure
#str(data)
#head(data)
#summary(data)

set.seed(1017)  # For random seed 

# Get indices of samples, random select 1
pos_idx <- which(data$Label == 1)
neg_idx <- which(data$Label == 0)
verif_pos <- sample(pos_idx, 1)
verif_neg <- sample(neg_idx, 1)

# Create DBs
verif_db <- data[c(verif_pos, verif_neg), ]
train_db <- data[-c(verif_pos, verif_neg), ]

Commenting out grid search after finding best model, but leaving it in
Check success
cat("Training DB:", nrow(train_db), "samples\nVerification DB:", nrow(verif_db), "samples")

library(randomForest)

# Ensure all parameters are being tested properly
tune_grid <- expand.grid(
  mtry = c(20, 25, 30),
  ntree = c(300, 500, 700),
  cutoff = I(list(c(0.5, 0.5), c(0.3, 0.7)))
)

# Verify all combinations
print(paste("Total combinations:", nrow(tune_grid)))  #total combinations, should be 18
head(tune_grid, 10)

# Modified evaluation loop
folds <- sample(rep(1:3, length.out = nrow(X_train)))
results <- list()

for(i in 1:nrow(tune_grid)) {
  params <- tune_grid[i, ]
  cat("\nTesting combination", i, "/", nrow(tune_grid),
      "| mtry =", params$mtry,
      "| ntree =", params$ntree,
      "| cutoff =", paste(params$cutoff[[1]], collapse = ","))

  fold_acc <- numeric(3)
  for(fold in 1:3) {
    train_idx <- which(folds != fold)
    valid_idx <- which(folds == fold)

    model <- randomForest(
      x = X_train[train_idx, ],
      y = y_train[train_idx],
      ntree = params$ntree,
      mtry = params$mtry,
      cutoff = params$cutoff[[1]],  # Proper list access
      importance = FALSE
    )
    fold_acc[fold] <- mean(predict(model, X_train[valid_idx, ]) == y_train[valid_idx])
  }

  results[[i]] <- data.frame(
    mtry = params$mtry,
    ntree = params$ntree,
    cutoff = paste(params$cutoff[[1]], collapse = ","),
    avg_accuracy = mean(fold_acc),
    stringsAsFactors = FALSE
  )
}

# Combine all results
#final_results <- do.call(rbind, results)
#final_results <- final_results[order(-final_results$avg_accuracy), ]

# View complete results
#print(final_results, row.names = FALSE)

library(randomForest)

# 1. Train final model
final_model <- randomForest(
  x = X_train,
  y = y_train,
  ntree = 300,
  mtry = 20,
  cutoff = c(0.5, 0.5),
  importance = TRUE
)

# 2. OOB Evaluation
# Get confusion matrix
oob_conf <- final_model$confusion[, 1:2]  # First two columns only
colnames(oob_conf) <- c("Predicted 0", "Predicted 1")
rownames(oob_conf) <- c("Actual 0", "Actual 1")

# Calculate metrics
TP <- oob_conf["Actual 1", "Predicted 1"]
TN <- oob_conf["Actual 0", "Predicted 0"] 
FP <- oob_conf["Actual 0", "Predicted 1"]
FN <- oob_conf["Actual 1", "Predicted 0"]

precision_val <- TP / (TP + FP)
recall_val <- TP / (TP + FN)
f1_val <- 2 * (precision_val * recall_val) / (precision_val + recall_val)

metrics <- data.frame(
  OOB_Error = final_model$err.rate[nrow(final_model$err.rate), "OOB"],
  Accuracy = (TP + TN) / sum(oob_conf),
  Precision = precision_val,
  Recall = recall_val,
  F1 = f1_val
)

# 3. Print results
cat("OOB Confusion Matrix:\n")
print(oob_conf)
cat("\nPerformance Metrics:\n")
print(metrics)

# 4. Verification set
X_verif <- verif_db[, -which(colnames(verif_db) == "Label")]
y_verif <- verif_db$Label
verif_pred <- predict(final_model, X_verif)
verif_cm <- table(Actual = y_verif, Predicted = verif_pred)

cat("\nVerification Set Confusion Matrix:\n")
print(verif_cm)

# Get importance scores
importance_scores <- importance(final_model)

# Convert to data frame and sort by MDA
feature_importance <- data.frame(
  Gene = rownames(importance_scores),
  MeanDecreaseAccuracy = importance_scores[, "MeanDecreaseAccuracy"],
  MeanDecreaseGini = importance_scores[, "MeanDecreaseGini"]
) |>
  dplyr::arrange(desc(MeanDecreaseAccuracy))

# Top 10 features
top_genes <- head(feature_importance, 10)
print(top_genes)

# Load verification data (already separated)
X_verif <- verif_db[, -which(colnames(verif_db) == "Label")]
y_verif_true <- verif_db$Label  # Ground truth labels

# Run predictions
verif_pred_class <- predict(final_model, X_verif)  # Class prediction (0/1)
verif_pred_prob <- predict(final_model, X_verif, type = "prob")  # Class probabilities

# Combine results
results <- data.frame(
  Sample_ID = rownames(verif_db),
  True_Label = y_verif_true,
  Predicted_Class = as.numeric(verif_pred_class) - 1,  # Convert factor to 0/1
  Probability_Negative = verif_pred_prob[, "0"],
  Probability_Positive = verif_pred_prob[, "1"]
)

print(results)

