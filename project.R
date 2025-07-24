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

#Grid search
tune_grid <- expand.grid(
  mtry = c(sqrt(25), 5, 10, 15, 20, 25),
  ntree = c(200, 300, 500, 700, 900, 1200),
  cutoff = I(list(c(0.5, 0.5), c(0.3, 0.7), c(0.3, 0.3)))
)

print(paste("Total combinations:", nrow(tune_grid))) #144
head(tune_grid, 10)

folds <- sample(rep(1:3, length.out = nrow(training_db)))
results <- list()

# Manual 3-fold CV 
for(i in 1:nrow(tune_grid)) {
  params <- tune_grid[i, ]
  cat("\nTesting combination", i, "/", nrow(tune_grid),
      "| mtry =", params$mtry,
      "| ntree =", params$ntree,
      "| cutoff =", paste(params$cutoff[[1]], collapse = ","))
  
  fold_acc <- numeric(3)
  for(fold in 1:3) {
    training_idx <- which(folds != fold)
    valid_idx <- which(folds == fold)
    
    model <- randomForest(
      x = x_train[training_idx, ],
      y = y_train[training_idx],
      ntree = params$ntree,
      mtry = params$mtry,
      cutoff = params$cutoff[[1]],  # Proper list access
      importance = FALSE
    )
    fold_acc[fold] <- mean(predict(model, x_train[valid_idx, ]) == y_train[valid_idx])
  }
  
  results[[i]] <- data.frame(
    mtry = params$mtry,
    ntree = params$ntree,
    cutoff = paste(params$cutoff[[1]], collapse = ","),
    avg_accuracy = mean(fold_acc),
    stringsAsFactors = FALSE
  )
}

final_results <- do.call(rbind, results)
final_results <- final_results[order(-final_results$avg_accuracy), ]

# View complete results
print(final_results, row.names = FALSE)