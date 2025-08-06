tune_grid <- expand.grid(
    mtry = c(sqrt(25), 5, 10, 15, 20, 25),
    ntree = c(300, 500, 700, 900, 1200, 2000, 3000),
    cutoff = I(list(c(0.7, 0.3)))
)

print(paste("Total combinations:", nrow(tune_grid)))
head(tune_grid, 10)

folds <- sample(rep(1:3, length.out = nrow(training_db)))
results <- list()

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
        
        preds <- predict(model, x_train[valid_idx, ])
        true_labels <- y_train[valid_idx]
        
        fold_acc[fold] <- mean(preds == true_labels)
        
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

print(final_results, row.names = FALSE)
