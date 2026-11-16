# Alzheimer's screening with a random forest

Five columns reproduce a synthetic Alzheimer's diagnosis almost as well as all thirty-four. Re-cut to favour recall, the same forest misses 16 of 757 positive cases instead of 61 — which is the operating point a screen should be judged on, not accuracy.

An experiment in R on [Rabie El Kharoua's public synthetic Alzheimer's dataset](https://www.kaggle.com/datasets/rabieelkharoua/alzheimers-disease-dataset), written as a three-person team project for CSC 659-859 at San Francisco State University, Summer 2025.

## Result

Six records are held out; the remaining 2,143 are scored out of bag, 1,386 negative and 757 positive.

| Cutoff (0 / 1) | Accuracy | Recall | Precision | Missed positives | Healthy flagged |
|---|---|---|---|---|---|
| 0.5 / 0.5 | 95.15% | 91.94% | 94.18% | 61 | 43 |
| 0.7 / 0.3 | 94.73% | 97.89% | 88.42% | 16 | 97 |

Lowering the positive threshold costs 0.42 points of accuracy and buys 45 fewer missed cases. For a first screen a false positive costs one follow-up appointment and a false negative costs a delayed diagnosis, so the trade is worth making. The hyperparameter sweep ranks by recall, which selects 0.7 / 0.3 at mtry 10 with 3,000 trees out of 35 configurations.

## What carries the model

FunctionalAssessment and ADL (clinician-rated function and independence), MMSE (the cognitive screen in standard use), plus the two patient-reported columns, MemoryComplaints and BehavioralProblems.

| Feature set | Trees' mtry | Accuracy | Healthy flagged | Missed cases |
|---|---|---|---|---|
| Five clinical columns only | 2 | 95.10% | 50 | 55 |
| All 34 columns | 10 | 94.73% | 97 | 16 |
| All except those five | 5 | 40.69% | 1,146 | 125 |

Each forest uses R's default mtry for its own feature count, all at the 0.7 / 0.3 cutoff. Accuracy is dominated by the healthy majority, so the five-column model scores marginally higher while recovering 39 fewer positive cases; the full model is the better screen. Drop those five columns entirely and accuracy falls to 40.69%, with 1,146 of 1,386 healthy records flagged.

## A row number ranks sixth

`PatientID` scores 101.63 — sixth of thirty-four, ahead of every genuine feature below the five clinical columns. It is a row index, not a measurement: 4,751 to 6,899, unique across all 2,149 records, correlated with the label at only 0.041. Its importance is identifier leakage, and removing it is the first recommendation in the writeup.

Below it, all 28 remaining columns sit between 4.35 (Age) and −4.02 (CholesterolTriglycerides). Across 2,143 out-of-bag records, that is nothing. `DoctorInCharge` is the degenerate case of the same problem: a placeholder string (`XXXConfid`) in every row, so it scores 0.000, as a column with no variance must.

## Reproducing

R 4.5.1 with `randomForest` (4.7-1.2) and `dplyr`.

```sh
Rscript export_results.R   # regenerates results/cutoff_comparison.csv and results/feature_importance.csv
Rscript ablation.R         # regenerates results/ablation.csv
```

`set.seed(999)` in `project.R` fixes both the verification split and the forest, so the committed data reproduces the reported figures exactly — the 0.7 / 0.3 operating point comes out at 94.73 / 97.89 / 88.42 with 16 missed cases on any current run.

## Files

| Path | What it is |
|---|---|
| `report.md` | Full writeup: data audit, method, results, ethics and trustworthiness audit, literature comparison |
| `project.R` | The analysis as submitted — split, forest, metrics, importance, verification set |
| `export_results.R` | Replays the seed and writes both cutoffs and the full importance table to `results/` |
| `ablation.R` | The five-column ablation above |
| `grid_search.R` | The mtry / ntree sweep; expects the objects built in `project.R` |
| `alzheimers_disease_data.csv` | The dataset, 2,149 records by 35 columns |
| `results/` | Generated CSVs, the run log, and the grid search table |
| `refs/` | The two papers compared against in section 7.5 |

## Limits

- Synthetic records. The label rate is 35% positive against roughly 0.3% in a real screening population, so accuracy here is not accuracy there and the field reports AUROC instead.
- The verification set is six records and scores 6/6. That is a smoke test, not external validation.
- `PatientID` is still present in the feature matrix used for the reported model.
- No subgroup fairness testing. The dataset's synthetic demographics cannot support it.
- This is a screening aid studied for audit, not a diagnostic tool.

## Where this is written up

- `report.md` — the full phase-I report
- [vb4r.com/projects/alzheimers-screening](https://vb4r.com/projects/alzheimers-screening/) — short public version

## Team

CSC 659-859, San Francisco State University, Summer 2025. Victoria Barnett led the team and wrote `project.R`: the model, the hyperparameter tuning, the evaluation metrics and the literature comparison. Ahmad Harris wrote the ethics and trustworthiness audit. Juan Mora wrote the motivation and the database audit.

## References

Li, M., Liu, H., Li, Y., Wang, Z., Yuan, Y., & Dai, H. (2024). *Intelligent Diagnosis of Alzheimer's Disease Based on Machine Learning*. arXiv:2402.08539.

Tang, A. S., Rankin, K. P., Cerono, G., Miramontes, S., et al. (2024). *Leveraging electronic health records and knowledge networks for Alzheimer's disease prediction and sex-specific biological insights*. Nature Aging. doi:10.1038/s43587-024-00573-8

El Kharoua, R. (2024). *Alzheimer's Disease Dataset*. Kaggle. Attribution licence.
