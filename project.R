# Assign data varibale
data <- alzheimers_disease_data

# random seed for later
set.seed(999) 

# Get indices of samples, 3 each of diagnosed or not to set aside
pos_idx <- which(data$Diagnosis == 1)
neg_idx <- which(data$Diagnosis == 0)

# random samples
verif_pos <- sample(pos_idx, 3)
verif_neg <- sample(neg_idx, 3)

# create dbs
verif_db <- data[c(verif_pos, verif_neg), ]
training_db <- data[-c(verif_pos, verif_neg), ]

# Create feature matrix and target vector for training
x_train <- training_db[, -which(colnames(training_db) == "Diagnosis")]
y_train <- as.factor(training_db$Diagnosis)



library(randomForest)

#Grid search optimized for recall (sensitivity) - minimize false negatives
tune_grid <- expand.grid(
  mtry = c(sqrt(25), 5, 10, 15, 20, 25),
  ntree = c(300, 500, 700, 900, 1200, 2000, 3000),
  cutoff = I(list(c(0.7, 0.3)))  # Favor detecting Alzheimer's
)

print(paste("Total combinations:", nrow(tune_grid))) #168
head(tune_grid, 10)

folds <- sample(rep(1:3, length.out = nrow(training_db)))
results <- list()

# Manual 3-fold CV optimizing for recall instead of accuracy
for(i in 1:nrow(tune_grid)) {
  params <- tune_grid[i, ]
  cat("\nTesting combination", i, "/", nrow(tune_grid),
      "| mtry =", params$mtry,
      "| ntree =", params$ntree,
      "| cutoff =", paste(params$cutoff[[1]], collapse = ","))
  
  fold_recall <- numeric(3)
  fold_acc <- numeric(3)
  for(fold in 1:3) {
    training_idx <- which(folds != fold)
    valid_idx <- which(folds == fold)
    
    model <- randomForest(
      x = x_train[training_idx, ],
      y = y_train[training_idx],
      ntree = params$ntree,
      mtry = params$mtry,
      cutoff = params$cutoff[[1]],
      importance = FALSE
    )
    
    # Calculate both recall and accuracy for this fold
    preds <- predict(model, x_train[valid_idx, ])
    true_labels <- y_train[valid_idx]
    
    # Accuracy
    fold_acc[fold] <- mean(preds == true_labels)
    
    # Recall = TP / (TP + FN) = TP / (all actual positives)
    tp <- sum(preds == 1 & true_labels == 1)
    fn <- sum(preds == 0 & true_labels == 1)
    recall <- ifelse((tp + fn) > 0, tp / (tp + fn), 0)
    
    fold_recall[fold] <- recall
  }
  
  results[[i]] <- data.frame(
    mtry = params$mtry,
    ntree = params$ntree,
    cutoff = paste(params$cutoff[[1]], collapse = ","),
    avg_recall = mean(fold_recall),
    avg_accuracy = mean(fold_acc),
    stringsAsFactors = FALSE
  )
}

final_results <- do.call(rbind, results)
final_results <- final_results[order(-final_results$avg_recall), ]

# View complete results
print(final_results, row.names = FALSE)

# Winner: 25, 300, (0.5,0.5) at highest accuracy (95.24%)
# 
# # train winning model with adjusted cutoff to minimize false negatives
# final_model <- randomForest(
#   x = x_train,
#   y = y_train,
#   ntree = 300,
#   mtry = 25,
#   cutoff = c(0.7, 0.3),  # Higher threshold for class 0 (healthy), lower for class 1 (Alzheimer's)
#   importance = TRUE
# )
# 
# # Get confusion matrix
# oob_conf <- final_model$confusion[, 1:2]  # First two columns only
# colnames(oob_conf) <- c("Predicted 0", "Predicted 1")
# rownames(oob_conf) <- c("Actual 0", "Actual 1")
# 
# # Calculate metrics
# TP <- oob_conf["Actual 1", "Predicted 1"]
# TN <- oob_conf["Actual 0", "Predicted 0"] 
# FP <- oob_conf["Actual 0", "Predicted 1"]
# FN <- oob_conf["Actual 1", "Predicted 0"]
# 
# precision_val <- TP / (TP + FP)
# recall_val <- TP / (TP + FN)
# f1_val <- 2 * (precision_val * recall_val) / (precision_val + recall_val)
# 
# metrics <- data.frame(
#   OOB_Error = final_model$err.rate[nrow(final_model$err.rate), "OOB"],
#   Accuracy = (TP + TN) / sum(oob_conf),
#   Precision = precision_val,
#   Recall = recall_val,
#   F1 = f1_val
# )
# 
# # 3. Print results
# cat("OOB Confusion Matrix:\n")
# print(oob_conf)
# cat("\nPerformance Metrics:\n")
# print(metrics)
# 
# # 4. Verification set
# x_verif <- verif_db[, -which(colnames(verif_db) == "Diagnosis")]
# y_verif <- verif_db$Diagnosis 
# verif_pred <- predict(final_model, x_verif)
# verif_cm <- table(Actual = y_verif, Predicted = verif_pred)
# 
# cat("\nVerification Set Confusion Matrix:\n")
# print(verif_cm)
# 
# 
# # Get importance scores
# importance_scores <- importance(final_model)
# 
# # Convert to data frame and sort by MDA
# feature_importance <- data.frame(
#   Factor = rownames(importance_scores),
#   MeanDecreaseAccuracy = importance_scores[, "MeanDecreaseAccuracy"],
#   MeanDecreaseGini = importance_scores[, "MeanDecreaseGini"]
# ) |>
#   dplyr::arrange(desc(MeanDecreaseAccuracy))
# 
# # Top 10 features
# top_features <- head(feature_importance, 10)
# print(top_features)
# 
# # Load verification data (already separated)
# x_verif <- verif_db[, -which(colnames(verif_db) == "Diagnosis")]
# y_verif_true <- verif_db$Diagnosis 
# 
# # Run predictions
# verif_pred_class <- predict(final_model, x_verif)  # Class prediction (0/1)
# verif_pred_prob <- predict(final_model, x_verif, type = "prob")  # Class probabilities
# 
# # Combine results
# results <- data.frame(
#   Sample_ID = rownames(verif_db),
#   True_Label = y_verif_true,
#   Predicted_Class = as.numeric(verif_pred_class) - 1,  # Convert factor to 0/1
#   Probability_Negative = verif_pred_prob[, "0"],
#   Probability_Positive = verif_pred_prob[, "1"]
# )
# 
# print(results)