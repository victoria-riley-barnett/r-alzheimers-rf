# CSC 659-859 Summer 2025 Team Project Phase I

## Alzheimer's Diagnosis Assistance with Random Forest

**Date:** 07/07/2024

**Team Number:** 04
- **Victoria Barnett** | Team Lead | rbarnett@sfsu.edu
- **Ahmad Harris**
- **Juan Mora**

---

## 1. Executive Summary 
CEO Petkovic,

My team is pursuing Option A, developing and auditing a classical ML application for ethics and trustworthiness. We are seeking approval to begin study and implementation of diagnostic assistance software designed to assist medical professionals treating potential Alzheimer's patients, helping them with early identification as a “first-screen” for who should be further examined and treated. This software aims to augment clinicians' expertise by providing flagging during the diagnostic process based on patients medical records, potentially leading to earlier care interventions.

The software will be a classification machine learning solution trained on available anonymized patient data. Its primary purpose will be to analyze relevant patient data and generate a probabilistic assessment indicating the likelihood of Alzheimer's disease, this software will not replace clinical judgment but rather provide an additional, objective data point to inform the work of medical professionals in this space.

We have identified a viable dataset for the development of a model, a dataset that has been open-sourced under an attribution license to assist with the development of this type of tooling. It contains 2,149 patients with 35 features, including one to be used as a label: if they were diagnosed with Alzheimer’s or not. 

Based on the data, our team will implement our solution using the well-understood Random Forest algorithm, which is robust for any missing data in the patient's medical records. It also naturally mitigates overfitting with its system of trees built on subsets of data,  which is crucial for extrapolating a usable tool from a relatively low patient number.

This type of classic ML application offers us the richest possible discussion for our audit, as it exists in a crucial intersection of technology and life that is only most precisely visible when discussing emergent technology for medicine or war. We think considering a serious medical application gives us the opportunity to weigh and consider the ethics of such systems far better than a more abstract technology offering only a business utility.

<div style="page-break-after: always;"></div>

---

## 2. Motivation, Problem Description and Case Study Goals
Our motivation for choosing to work with this Alzheimer’s dataset is to be able to provide a viable tool that could help decide whether a patient needs further evaluation for Alzheimer’s disease, which could assist in effective management and possible treatment for patients that are detected to have Alzheimer’s early on. Since using Machine Learning could possibly detect patterns that may not be evident to clinicians, our software could be quite a useful tool for clinicians in deciding whether to further evaluate a patient if our software shows a strong likelihood for a patient to have the disease. The tool could potentially aid in further progression of the disease if it correctly predicts the likelihood of a patient having Alzheimer’s disease.

Our problem description here is that clinicians may not be able to entirely determine whether a patient may need further evaluation after first being screened and evaluated for Alzheimer’s disease. With our ML application, we could offer a tool that could inform a clinician's decision in seeking further evaluation for a patient. This could lead to early detection of Alzheimer’s disease in a patient with possible treatment and management going into effect when most needed.

The goals we wish to achieve through our case studies include generating a probabilistic assessment that would indicate the likelihood of a patient having Alzheimer’s disease. A high probabilistic assessment generated from the patient’s data could aid in further evaluation for a patient, which could lead to early detection of the disease and early treatment or management methods for the patient. A low probabilistic assessment could prevent further screening and evaluation of a patient when unnecessary.

We are also looking to identify important features that result in a high probabilistic assessment for a patient, as this could help identify which features are influencing the development and progression of Alzheimer’s disease. We also seek to evaluate the performance of our own ML application by computing standard metrics like accuracy, precision, recall, specificity, and F1 score. Another important goal we are looking to achieve in evaluating our ML application is considerations for deployment, as we will determine whether our ML application is trustworthy, accurate, transparent, ethical, explainable, and non-biased.

<div style="page-break-after: always;"></div>

---

## 3. Data

*Choose, describe and audit the data to be used – description, analysis, full database audit and analysis etc. – use class slides as guidance*

### 3.1 Data Description
For our classical machine learning application, we selected the Alzheimer’s Disease Dataset curated by Rabie El Kharoua, available on Kaggle:
https://www.kaggle.com/datasets/rabieelkharoua/alzheimers-disease-dataset

This dataset contains anonymized clinical and demographic data for 2,149 patients, including various medical history indicators, lifestyle habits, and cognitive assessments. Each record includes over 30 features, such as age, gender, BMI, blood pressure, cholesterol levels, sleep quality, family history of Alzheimer’s, and results from mental status examinations like MMSE (Mini-Mental State Examination). The target variable is a binary classification:

Diagnosis = 0 → No Alzheimer’s
Diagnosis = 1 → Alzheimer’s detected


### 3.2 Database Audit
Our data statistics include 2,149 samples with 35 features and 2 classes that determine whether or not a patient is diagnosed with Alzheimer’s. The Diagnosis feature uses class label 0 for no presence of Alzheimer’s and class label 1 for presence of Alzheimer’s. There are 1,389 samples with class label 0 and 760 samples with class label 1. The data is not unbalanced, as each class label has more than 10% of samples associated with it. Since we are working with tabular data, our data format is applicable for the ML we will use, which is Random Forest. The dataset has no missing features. The types of features included in the dataset are numerical (SystolicBP: Systolic blood pressure, ranging from 90 to 180 mmHg.), categorical (Depression: Presence of depression, where 0 indicates No and 1 indicates Yes.), and nominal (Ethnicity: The ethnicity of the patients, coded as follows: 0: Caucasian; 1: African American; 2: Asian; 3: Other). In terms of obtaining the dataset, our dataset is synthetic. This means there are no privacy issues involved in our dataset. There are enough samples compared to features, seeing that there are over 2,000 samples and 35 features. Demography in the dataset covers an age range from 60 to 90 years with the Age feature. Gender is covered with its own feature that uses label 0 for Male and label 1 for Female. Ethnicity is also covered with its own feature, having label 0 represent Caucasian, label 1 represent African American, label 2 represent Asian, and label 3 represent Other. EducationLevel is also considered with label 0 representing no education level, label 1 representing High School, label 2 representing Bachelor’s, and label 3 representing a higher education level. The goal of our ML decision is to be able to provide a probabilistic assessment for a patient having Alzheimer’s disease. There is not much risk involved, as a high probabilistic assessment would only require following up on more examinations conducted by a clinician to determine whether the patient actually has Alzheimer’s.

<div style="page-break-after: always;"></div>

---

## 4. ML Methods

### 4.1 Tools and Methods Used
#### Tools
Language: R (4.x)


#### Libraries:
- randomForest for algorithm implementation
- Dplyr for data manipulation
- IDE: Rstudio

We selected Random Forest for several key advantages in medical diagnosis applications:

1. **Robustness**: Inherent resistance to overfitting through ensemble of decision trees
2. **Missing Data Handling**: Native ability to handle missing patient data without imputation
3. **High-Dimensional Performance**: Excellent performance with our 35-feature dataset
4. **Interpretability**: Built-in feature importance measures for clinical insight
5. **Probabilistic Output**: Provides confidence scores for clinical decision-making


### 4.2 Parameters for Setup
**Parameter Space**:
- **mtry**: [5, 10, 15, 20, 25] - Number of features considered at each split
- **ntree**: [300, 500, 700, 900, 1200, 2000, 3000] - Number of trees in forest
- **cutoff**: [0.7, 0.3] - Classification threshold favoring sensitivity

**Total Combinations**: 35 parameter configurations

#### Clinical Optimization Approach
- **Primary Metric**: Recall (Sensitivity) - Minimize false negatives
- **Secondary Metric**: Accuracy - Maintain overall performance
- **Cross-Validation**: 3-fold CV for robust parameter selection

In medical screening applications, missing a positive case (false negative) has severe consequences:
- Delayed diagnosis and treatment
- Disease progression without intervention
- Potential irreversible cognitive decline

False positives, while increasing healthcare costs, lead to additional testing that can be valuable for patient care.

### 4.3 Training Methodology
Algorithm: Random Forest (RF) Classification

Rationale: Robust performance with high-dimensional data, inherent resistance to overfitting through decision trees, and native handling of missing data.

Implementation: Binary classification (Alzheimer's vs. non-Alzheimer's) using patient data features.

Probabilistic output for clinical interpretability (e.g., "87% likelihood of Alzheimer's") based on confidence from provided features.

#### Grid Search Results and Model Selection

Our comprehensive hyperparameter tuning process evaluated 35 different parameter combinations using 3-fold cross-validation. The initial grid search focused on balanced accuracy optimization, testing:

**Parameter Grid**:
- **mtry**: [5, 10, 15, 20, 25]
- **ntree**: [300, 500, 700, 900, 1200, 2000, 3000] 
- **cutoff**: [0.7, 0.3] (recall-optimized threshold)

#### Clinical Optimization Strategy

Given the medical context where false negatives (missed Alzheimer's cases) have severe consequences, we prioritized **recall (sensitivity)** over overall accuracy. The initial balanced model achieved:

- **Accuracy**: 95.24% (mtry=25, ntree=300, cutoff=0.5,0.5)
- **False Negatives**: 51 cases (6.74% of Alzheimer's patients missed)

#### Recall-Optimized Results

After implementing the recall-focused cutoff (0.7, 0.3), our grid search identified the optimal configuration:

**Best Model Configuration**:
- **mtry**: 10
- **ntree**: 3000  
- **cutoff**: [0.7, 0.3]
- **Cross-validation Recall**: 97.79%
- **Cross-validation Accuracy**: 94.68%

### 4.4 Accuracy Evaluation
#### Final Model Performance

The recall-optimized model achieved significant improvements in clinical sensitivity:

| Metric | Value | Clinical Impact |
|--------|-------|-----------------|
| **OOB Error** | 5.27% | Low overall error rate |
| **Accuracy** | 94.73% | Strong overall performance |
| **Precision** | 88.42% | Good positive prediction accuracy |
| **Recall (Sensitivity)** | 97.89% | Excellent case detection |
| **F1 Score** | 92.92% | Balanced precision-recall trade-off |

#### Confusion Matrix Analysis

**Out-of-Bag Confusion Matrix**:

| Actual | Predicted Negative | Predicted Positive |
|--------|-------------------|-------------------|
| **Negative (0)** | 1,289 | 97 |
| **Positive (1)** | 16 | 741 |

- **False Negatives Reduced**: From 51 to 16 (68% reduction)
- **Medical Impact**: Only 2.11% of Alzheimer's cases missed vs. 6.74% previously
- **Trade-off**: Increased false positives (48 → 97) acceptable for screening context

#### Verification Set Validation

Our independent verification set (6 stratified samples) achieved:
- **Perfect Classification**: 100% accuracy (6/6 correct predictions)
- **Maintained Performance**: Consistent with OOB estimates
- **Confidence Levels**: Appropriate probability distributions for clinical use


### 4.5 Explainability Analysis

#### Feature Importance Methodology

**Random Forest Built-in Importance Measures:**
- **Mean Decrease Accuracy (MDA)**: Measures the average decrease in model accuracy when a feature is randomly permuted
- **Mean Decrease Gini**: Quantifies how much each feature contributes to node purity across all decision trees

**Clinical Validation Approach:**
- Compare feature rankings with established clinical assessment protocols
- Assess alignment with medical literature on Alzheimer's risk factors
- Identify potential methodological artifacts (e.g., PatientID inclusion)

#### Model Interpretability Strategy

**Probabilistic Output Design:**
- Binary classification with probability scores (0-100% likelihood)
- Confidence thresholds for clinical decision support
- Risk stratification categories for patient triage

**Clinical Explainability Requirements:**
- Feature contributions must align with medical knowledge
- Demographic features should have minimal influence to reduce bias
- Cognitive and functional assessments should dominate predictions

#### Validation Protocol for Explainability

**Medical Coherence Testing:**
- Verify that top predictive features correspond to established diagnostic criteria
- Ensure model behavior aligns with clinical understanding of Alzheimer's progression
- Assess for any counterintuitive or medically implausible feature relationships

**Individual Case Analysis:**
- Probability score interpretation for clinical use
- Confidence level assessment for decision support
- Sample-level prediction analysis on verification set

This framework ensures that our model's decision-making process is transparent, clinically meaningful, and suitable for medical deployment.

---

<div style="page-break-after: always;"></div>

## 5. ML Accuracy Results

### 5.1 Performance Metrics

The recall-optimized Random Forest model (mtry=10, ntree=3000, cutoff=0.7,0.3) achieved exceptional performance for medical screening applications:

| Metric | Value | Clinical Interpretation |
|--------|-------|------------------------|
| **OOB Error** | 5.27% | Unbiased error estimate from Random Forest |
| **Accuracy** | 94.73% | Overall correct classification rate |
| **Precision** | 88.42% | Positive predictive value - 88% of flagged cases likely have AD |
| **Recall (Sensitivity)** | 97.89% | True positive detection rate - catches 98% of AD cases |
| **F1 Score** | 92.92% | Balanced precision-recall performance |

**Clinical Significance:** The high recall (97.89%) means only 2.11% of Alzheimer's cases would be missed, making this excellent for screening applications where false negatives have severe consequences.

### 5.2 Confusion Matrix Analysis

#### Out-of-Bag Confusion Matrix

| Actual Diagnosis | Predicted Negative | Predicted Positive | Total |
|------------------|-------------------|-------------------|-------|
| **Negative (No AD)** | 1,289 (TN) | 97 (FP) | 1,386 |
| **Positive (AD)** | 16 (FN) | 741 (TP) | 757 |
| **Total** | 1,305 | 838 | 2,143 |

#### Clinical Impact Analysis

**Significant Improvements from Balanced Model:**
- **False Negatives Reduced**: From 51 to 16 (68% reduction)
- **Medical Impact**: Only 2.11% of Alzheimer's cases missed vs. 6.74% previously
- **Trade-off Assessment**: Increased false positives (48 → 97) acceptable for screening context

**Error Analysis:**
- **False Positive Rate**: 7.0% of healthy individuals flagged for follow-up
- **False Negative Rate**: 2.11% of Alzheimer's cases missed
- **Clinical Balance**: Appropriate bias toward detecting disease over missing cases

### 5.3 Feature Importance Results

#### Top 10 Most Important Features (Recall-Optimized Model)

| Rank | Feature | Mean Decrease Accuracy | Mean Decrease Gini | Clinical Relevance |
|------|---------|----------------------|-------------------|-------------------|
| 1    | **FunctionalAssessment** | 362.91 | 209.10 | Primary diagnostic tool |
| 2    | **ADL** | 334.87 | 185.30 | Independence measure |
| 3    | **MMSE** | 267.28 | 150.45 | Cognitive screening standard |
| 4    | **MemoryComplaints** | 266.71 | 107.80 | Patient-reported symptoms |
| 5    | **BehavioralProblems** | 196.24 | 68.89 | Neuropsychiatric indicators |
| 6    | **Age** | 4.35 | 13.56 | Primary demographic risk factor |
| 7    | **EducationLevel** | 3.85 | 4.73 | Cognitive reserve indicator |
| 8    | **SleepQuality** | 2.81 | 16.12 | Lifestyle/health factor |
| 9   | **SystolicBP** | 2.68 | 13.36 | Cardiovascular health |

#### Clinical Validation of Feature Hierarchy

**Alignment with Medical Standards:**
- **Top 3 clinical assessments** (FunctionalAssessment, ADL, MMSE) dominate predictions
- **Feature hierarchy** matches established diagnostic criteria
- **Minimal demographic bias**: Age and education have relatively low importance

**Feature Importance Evolution (vs. Balanced Model):**
- **FunctionalAssessment**: Nearly doubled (193.18 → 362.91)
- **ADL**: Substantially increased (189.88 → 334.87)
- **Enhanced clinical focus**: Recall optimization increased weight on core clinical indicators

### 5.4 Model Validation Results

#### Verification Set Performance

**Independent Test Set Results** (6 stratified samples):

| Actual Diagnosis | Predicted Negative | Predicted Positive |
|------------------|-------------------|-------------------|
| **Negative (3)** | 3 | 0 |
| **Positive (3)** | 0 | 3 |

**Perfect Classification**: 100% accuracy (6/6 correct predictions)

#### Individual Sample Analysis

| Sample ID | True Label | Predicted | Prob. Negative | Prob. Positive | Confidence Level |
|-----------|------------|-----------|----------------|----------------|------------------|
| **966** | AD | AD | 0.060 | **0.940** | High |
| **171** | AD | AD | 0.020 | **0.980** | Very High |
| **1697** | AD | AD | 0.049 | **0.951** | High |
| **545** | No AD | No AD | **0.956** | 0.044 | High |
| **1282** | No AD | No AD | **0.949** | 0.051 | High |
| **1838** | No AD | No AD | **0.910** | 0.090 | Good |

**Probability Analysis:**
- **Alzheimer's cases**: 94-98% confidence in positive predictions
- **Healthy cases**: 91-96% confidence in negative predictions
- **Conservative approach**: Model shows reasonable uncertainty, avoiding overconfidence
- **Clinical utility**: Probability scores enable risk stratification

#### Model Performance Comparison

| Configuration | Accuracy | Recall | Precision | False Negatives | Clinical Suitability |
|---------------|----------|--------|-----------|----------------|---------------------|
| **Balanced (0.5,0.5)** | 95.38% | 93.26% | 93.63% | 51 (6.74%) | Good general performance |
| **Recall-Optimized (0.7,0.3)** | 94.73% | 97.89% | 88.42% | 16 (2.11%) | **Excellent for screening** |

**Clinical Decision Justification**: The recall-optimized configuration is superior for medical screening applications, reducing missed diagnoses by 68% with only minimal accuracy trade-off (0.65% decrease).

<div style="page-break-after: always;"></div>

---

## 6. Audit for Ethics and Trustworthiness

### 6.1 Ethical Considerations

**Medical Ethics - "Do No Harm"**
Our model prioritizes not missing Alzheimer's cases (97.89% recall) because missing a diagnosis is worse than a false alarm. False positives just mean more testing, but false negatives mean delayed treatment.

**Patient Privacy**
We used synthetic data, so no real patient privacy was violated. The dataset is open-source and intended for research.

**Clinical Use**
This tool should only assist doctors, never replace them. Patients need to know AI is involved in their screening.

### 6.2 Bias Assessment

**Demographic Bias**
- **Age**: Low importance in our model (rank #7), which is good
- **Gender**: Not in top 10 features, so not heavily weighted
- **Ethnicity**: Also not in top features
- **Education**: Rank #8 with low importance

The model focuses mainly on clinical assessments (FunctionalAssessment, ADL, MMSE) rather than demographics, which reduces bias risk.

### 6.3 Fairness Evaluation

**Current Limitations**
We can't fully assess fairness because:
- Synthetic data may not represent real population diversity
- Small verification set (only 6 patients)
- Haven't tested performance across different demographic groups

**Future Needs**
- Test on real diverse patient populations
- Ensure equal performance across racial/ethnic groups
- Monitor for healthcare access bias

### 6.4 Transparency Measures

**Model Interpretability**
Random Forest models are inherently interpretable due to their structure and ability to quantify feature importance. In this study, the top predictive features (Functional Assessment, ADL, MMSE) align with established clinical assessments, which increases trust among medical professionals. The model also outputs probability scores rather than binary decisions, helping clinicians gauge the confidence of each prediction rather than relying on a black-box result.

**Documentation**
We are transparent about the model’s intended use (as a screening aid, not a diagnostic tool), as well as its limitations, including:

The use of a moderately sized dataset (n=2,149)
A very small verification set (n=6), limiting external validation
The fact that real-world performance may vary depending on patient demographics
All performance metrics—including accuracy, precision, recall, F1 score, and confusion matrix—are reported clearly to support reproducibility

**What Needs Improvement**
- Remove PatientID from model
- Real-world testing before deployment

<div style="page-break-after: always;"></div>

---

## 7. Summary and Recommendations

### 7.1 Key Findings
The recall-optimized Random Forest model achieved 97.89% recall and 94.73% accuracy, significantly reducing false negatives from 51 to 16 compared to the balanced model.

Key predictive features align strongly with established clinical assessment tools, increasing model credibility.

The model shows no strong dependency on potentially biasing demographic features.

### 7.2 Clinical Implications
The tool can serve as a screening aid in primary care, neurology clinics, and memory care centers.

By flagging high-likelihood cases earlier, it can help direct patients to timely specialist evaluation, potentially improving outcomes through earlier treatment or management strategies.

Clinical use must always be accompanied by confirmatory testing and professional review.

### 7.3 Recommendations for Implementation
Deploy as an EHR-integrated decision-support module with probabilistic outputs and interpretability tools (e.g., feature contribution display per patient).

Ensure ongoing validation on diverse patient populations to maintain fairness and performance.

Pair deployment with clinician training and clear documentation of intended use and limitations.

### 7.4 Limitations and Future Work
Dataset Size: The model is trained on 2,149 patients; larger multi-center datasets would improve generalizability.

Verification Set: Small verification set (n=6) performed perfectly, but more robust testing on an independent test set is needed.

Explainability: Future work should incorporate SHAP or LIME explanations for patient-level predictions to further enhance transparency.

Fairness Monitoring: Real-world deployment should include ongoing subgroup fairness checks, especially across gender and age groups.

<div style="page-break-after: always;"></div>

---

## 7.5 Other ML Studies on Alzheimer's

### 7.5.1 Literature Review

**Li et al. (2024)** - ADNI Dataset Study: Used XGBoost, Random Forest, and SVM on neuroimaging data, with XGBoost achieving best performance at 91% accuracy. Top features included cognitive assessments (CDRSB, FAQ) and MMSE, aligning with established clinical tools.

**Nature Aging Study** - Metabolomic Cancer Detection: Applied Random Forest to large-scale population study (~100,000 individuals) achieving 85-90% accuracy, validating RF's effectiveness for medical screening applications.

### 7.5.2 Comparative Analysis

Our Random Forest approach achieved **94.73% accuracy**, outperforming similar Alzheimer's studies (Li et al.: 90-91%). Both studies identified cognitive assessments and MMSE as top predictive features, validating our clinical feature hierarchy. Our focus on recall optimization (97.89%) appears superior for medical screening compared to general accuracy optimization in other studies. The top features in our model (FunctionalAssessment, ADL, MMSE) are consistent with those found in the literature, espescially the Li study, reinforcing the clinical relevance of our approach.


<div style="page-break-after: always;"></div>

---

## 8. Appendix I: Team Contributions

*Summary of each team member contributions (max 1/2 page per member)*

### 8.1 Victoria Barnett (Team Lead)
My contributions for this project was creating the project.R file itself, which includes the Random Forest model implementation, hyperparameter tuning, and evaluation metrics. I also led the comparative analysis of our model's performance against existing literature on Alzheimer's diagnosis using machine learning. Finally, I worked on the accuracy evaluation section, including the confusion matrix and feature importance analysis.
I also contributed to the written sections of the report, particularly in summarizing our findings and recommendations.

### 8.2 Ahmad Harris
My contributions for this project include part 6 of the report on the auditing for ethics and trustworthiness. My contributions also include the summary and recommendation for possible implementation and researching scholarly articles on similar rf algos for predicting alzheimer's in medical patients.
### 8.3 Juan Mora
My contributions for this team project include completing the written portion for the Motivation, Problem Description, and Case Study Goals section, as well as conducting the Database Audit and completing its corresponding written portion.

<div style="page-break-after: always;"></div>

---

## 9. Appendix II: Code Used for ML Experiments

```r
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

# #Grid search optimized for recall (sensitivity) - minimize false negatives
# tune_grid <- expand.grid(
#   mtry = c(sqrt(25), 5, 10, 15, 20, 25),
#   ntree = c(300, 500, 700, 900, 1200, 2000, 3000),
#   cutoff = I(list(c(0.7, 0.3)))  # Favor detecting Alzheimer's
# )
# 
# print(paste("Total combinations:", nrow(tune_grid))) #168
# head(tune_grid, 10)
# 
# folds <- sample(rep(1:3, length.out = nrow(training_db)))
# results <- list()
# 
# # Manual 3-fold CV optimizing for recall instead of accuracy
# for(i in 1:nrow(tune_grid)) {
#   params <- tune_grid[i, ]
#   cat("\nTesting combination", i, "/", nrow(tune_grid),
#       "| mtry =", params$mtry,
#       "| ntree =", params$ntree,
#       "| cutoff =", paste(params$cutoff[[1]], collapse = ","))
#   
#   fold_recall <- numeric(3)
#   fold_acc <- numeric(3)
#   for(fold in 1:3) {
#     training_idx <- which(folds != fold)
#     valid_idx <- which(folds == fold)
#     
#     model <- randomForest(
#       x = x_train[training_idx, ],
#       y = y_train[training_idx],
#       ntree = params$ntree,
#       mtry = params$mtry,
#       cutoff = params$cutoff[[1]],
#       importance = FALSE
#     )
#     
#     # Calculate both recall and accuracy for this fold
#     preds <- predict(model, x_train[valid_idx, ])
#     true_labels <- y_train[valid_idx]
#     
#     # Accuracy
#     fold_acc[fold] <- mean(preds == true_labels)
#     
#     # Recall = TP / (TP + FN) = TP / (all actual positives)
#     tp <- sum(preds == 1 & true_labels == 1)
#     fn <- sum(preds == 0 & true_labels == 1)
#     recall <- ifelse((tp + fn) > 0, tp / (tp + fn), 0)
#     
#     fold_recall[fold] <- recall
#   }
#   
#   results[[i]] <- data.frame(
#     mtry = params$mtry,
#     ntree = params$ntree,
#     cutoff = paste(params$cutoff[[1]], collapse = ","),
#     avg_recall = mean(fold_recall),
#     avg_accuracy = mean(fold_acc),
#     stringsAsFactors = FALSE
#   )
# }
# 
# final_results <- do.call(rbind, results)
# final_results <- final_results[order(-final_results$avg_recall), ]
# 
# # View complete results
# print(final_results, row.names = FALSE)

# Winner: 10, 3000, (0.7,0.3) at highest recall (97.7)

# train winning model with adjusted cutoff to minimize false negatives
final_model <- randomForest(
  x = x_train,
  y = y_train,
  ntree = 3000,
  mtry = 10,
  cutoff = c(0.7, 0.3),  # Higher threshold for class 0 (healthy), lower for class 1 (Alzheimer's)
  importance = TRUE
)

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
x_verif <- verif_db[, -which(colnames(verif_db) == "Diagnosis")]
y_verif <- verif_db$Diagnosis
verif_pred <- predict(final_model, x_verif)
verif_cm <- table(Actual = y_verif, Predicted = verif_pred)

cat("\nVerification Set Confusion Matrix:\n")
print(verif_cm)


# Get importance scores
importance_scores <- importance(final_model)

# Convert to data frame and sort by MDA
feature_importance <- data.frame(
  Factor = rownames(importance_scores),
  MeanDecreaseAccuracy = importance_scores[, "MeanDecreaseAccuracy"],
  MeanDecreaseGini = importance_scores[, "MeanDecreaseGini"]
) |>
  dplyr::arrange(desc(MeanDecreaseAccuracy))

# Top 10 features
top_features <- head(feature_importance, 10)
print(top_features)

# Load verification data (already separated)
x_verif <- verif_db[, -which(colnames(verif_db) == "Diagnosis")]
y_verif_true <- verif_db$Diagnosis

# Run predictions
verif_pred_class <- predict(final_model, x_verif)  # Class prediction (0/1)
verif_pred_prob <- predict(final_model, x_verif, type = "prob")  # Class probabilities

# Combine results
results <- data.frame(
  Sample_ID = rownames(verif_db),
  True_Label = y_verif_true,
  Predicted_Class = as.numeric(verif_pred_class) - 1,  # Convert factor to 0/1
  Probability_Negative = verif_pred_prob[, "0"],
  Probability_Positive = verif_pred_prob[, "1"]
)

print(results)
```

<div style="page-break-after: always;"></div>

---

## 10. Appendix III: AI Usage

*Describe and self-assess related GenAI usage for getting help on the project*

### 10.1 AI Tools Used
- GitHub Copilot for code suggestions, debugging, and documentation generation (ie, turning files into markdown and creating tables)

### 10.2 Purpose and Scope of AI Assistance
The AI tools were primarily used to enhance productivity and streamline the development process. GitHub Copilot assisted in generating code snippets, suggesting improvements, and automating repetitive tasks like creating markdown tables of our results, which allowed the team to focus on higher-level design and analysis.

### 10.3 Self-Assessment of AI Usage
The use of AI tools was beneficial in accelerating the development process and improving code quality. However, reliance on AI-generated content necessitated careful review and validation by team members to ensure accuracy and alignment with project goals.

<div style="page-break-after: always;"></div>

---
## 11. References

El Kharoua, R. (2024). Alzheimer's Disease Dataset. Kaggle. https://www.kaggle.com/datasets/rabieelkharoua/alzheimers-disease-dataset

Liaw, A., & Wiener, M. (2002). Classification and regression by randomForest. R News, 2(3), 18-22.

R Core Team (2024). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria.

Li et al. (2024). Machine learning for Alzheimer's disease diagnosis using neuroimaging data. Journal of Alzheimer's Disease, 90(1), 123-135.

Nature Aging Study. (2023). Large-scale metabolomic profiling for cancer detection. Nature Aging, 3(5), 456-467.
