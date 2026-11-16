# Reproduces every number reported in report.md and in the public writeup.
# Run from the repository root: Rscript export_results.R
#
# project.R remains the original graded analysis and is the single source of
# truth for the recall-optimized model. This script only adds the balanced
# cutoff, taken on the same seed and the same split, so that the two rows of
# the comparison differ by threshold alone.

alzheimers_disease_data <- read.csv("alzheimers_disease_data.csv")

source("project.R")

suppressPackageStartupMessages(library(randomForest))

metrics <- function(model, cutoff) {
  cm <- model$confusion[, 1:2]
  tp <- cm["1", "1"]
  tn <- cm["0", "0"]
  fp <- cm["0", "1"]
  fn <- cm["1", "0"]
  data.frame(
    cutoff = cutoff,
    accuracy = round(100 * (tp + tn) / sum(cm), 2),
    recall = round(100 * tp / (tp + fn), 2),
    precision = round(100 * tp / (tp + fp), 2),
    false_negatives = fn,
    false_positives = fp
  )
}

set.seed(999)
invisible(sample(which(alzheimers_disease_data$Diagnosis == 1), 3))
invisible(sample(which(alzheimers_disease_data$Diagnosis == 0), 3))

balanced_model <- randomForest(
  x = x_train,
  y = y_train,
  ntree = 3000,
  mtry = 10,
  cutoff = c(0.5, 0.5),
  importance = FALSE
)

comparison <- rbind(
  metrics(balanced_model, "0.5,0.5"),
  metrics(final_model, "0.7,0.3")
)

print(comparison, row.names = FALSE)

dir.create("results", showWarnings = FALSE)
write.csv(feature_importance, "results/feature_importance.csv", row.names = FALSE)
write.csv(comparison, "results/cutoff_comparison.csv", row.names = FALSE)
