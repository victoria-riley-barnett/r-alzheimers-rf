# Ablation: how much of the model is the five clinical columns?
# Each forest uses the randomForest default mtry for its own feature count and
# the recall-optimized cutoff used for the operating model.
# Run from the repository root: Rscript ablation.R

data <- read.csv("alzheimers_disease_data.csv")

set.seed(999)
pos_idx <- which(data$Diagnosis == 1)
neg_idx <- which(data$Diagnosis == 0)
verif_pos <- sample(pos_idx, 3)
verif_neg <- sample(neg_idx, 3)
training_db <- data[-c(verif_pos, verif_neg), ]

x_train <- training_db[, -which(colnames(training_db) == "Diagnosis")]
y_train <- as.factor(training_db$Diagnosis)

suppressPackageStartupMessages(library(randomForest))

core <- c("MMSE", "FunctionalAssessment", "ADL", "MemoryComplaints", "BehavioralProblems")
rest <- setdiff(colnames(x_train), core)

score <- function(columns) {
  set.seed(999)
  fit <- randomForest(
    x = x_train[, columns],
    y = y_train,
    ntree = 3000,
    cutoff = c(0.7, 0.3),
    importance = FALSE
  )
  cm <- fit$confusion[, 1:2]
  data.frame(
    features = length(columns),
    mtry = fit$mtry,
    accuracy = round(100 * sum(diag(cm)) / sum(cm), 2),
    false_positives = cm["0", "1"],
    false_negatives = cm["1", "0"]
  )
}

ablation <- rbind(
  data.frame(columns = "five clinical only", score(core)),
  data.frame(columns = "all except the five", score(rest))
)

print(ablation, row.names = FALSE)

dir.create("results", showWarnings = FALSE)
write.csv(ablation, "results/ablation.csv", row.names = FALSE)
