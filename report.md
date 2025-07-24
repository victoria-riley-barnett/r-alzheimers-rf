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


### 3.2 Data Analysis
[Content to be added]

### 3.3 Database Audit
Our data statistics include 2,149 samples with 35 features and 2 classes that determine whether or not a patient is diagnosed with Alzheimer’s. The Diagnosis feature uses class label 0 for no presence of Alzheimer’s and class label 1 for presence of Alzheimer’s. There are 1,389 samples with class label 0 and 760 samples with class label 1. The data is not unbalanced, as each class label has more than 10% of samples associated with it. Since we are working with tabular data, our data format is applicable for the ML we will use, which is Random Forest. The dataset has no missing features. The types of features included in the dataset are numerical (SystolicBP: Systolic blood pressure, ranging from 90 to 180 mmHg.), categorical (Depression: Presence of depression, where 0 indicates No and 1 indicates Yes.), and nominal (Ethnicity: The ethnicity of the patients, coded as follows: 0: Caucasian; 1: African American; 2: Asian; 3: Other). In terms of obtaining the dataset, our dataset is synthetic. This means there are no privacy issues involved in our dataset. There are enough samples compared to features, seeing that there are over 2,000 samples and 35 features. Demography in the dataset covers an age range from 60 to 90 years with the Age feature. Gender is covered with its own feature that uses label 0 for Male and label 1 for Female. Ethnicity is also covered with its own feature, having label 0 represent Caucasian, label 1 represent African American, label 2 represent Asian, and label 3 represent Other. EducationLevel is also considered with label 0 representing no education level, label 1 representing High School, label 2 representing Bachelor’s, and label 3 representing a higher education level. The goal of our ML decision is to be able to provide a probabilistic assessment for a patient having Alzheimer’s disease. There is not much risk involved, as a high probabilistic assessment would only require following up on more examinations conducted by a clinician to determine whether the patient actually has Alzheimer’s.

<div style="page-break-after: always;"></div>

---

## 4. ML Methods

*Describe RF methods to be used with chosen data using SciKit or R - follow ML best practices as in HW 2*

### 4.1 Tools and Methods Used
#### Tools
Stack:

Language: R

#### Libraries:

randomForest for algorithm implementation

Dplyr for data manipulation

IDE: Rstudio


### 4.2 Parameters for Setup
[Content to be added]

### 4.3 Training Methodology
Algorithm: Random Forest (RF) Classification

Rationale: Robust performance with high-dimensional data, inherent resistance to overfitting through decision trees, and native handling of missing data.

Implementation: Binary classification (Alzheimer's vs. non-Alzheimer's) using patient data features.

Probabilistic output for clinical interpretability (e.g., "87% likelihood of Alzheimer's") based on confidence from provided features.

#### Hyperparameter Optimization & Validation
We will grid search 108 combinations to ensure we select the best RF setup for our data

We can perform 3-fold cross validation for robust accuracy evaluation during tuning while selecting best model
#### Performance Evaluation
After selecting best model, we can evaluate using a variety of robust measures on new data (ie, not our training data) to find:

Accuracy, Precision, Recall, F1 score, ROC & AUC discrimination ability, Confusion Matrix & OOB error check, Clinical consistency check (ie, see if our model identifies the same most important factors as a Doctor would)

### 4.4 Accuracy Evaluation
[Content to be added]

### 4.5 Explainability Analysis
[Content to be added]

<div style="page-break-after: always;"></div>

---

## 5. ML Accuracy Results

*Present full accuracy and explainability results (similar to HW 2). Adhere to full provenance*

### 5.1 Performance Metrics
[Content to be added]

### 5.2 Confusion Matrix Analysis
[Content to be added]

### 5.3 Feature Importance
[Content to be added]

### 5.4 Model Validation
[Content to be added]

<div style="page-break-after: always;"></div>

---

## 6. Audit for Ethics and Trustworthiness

*Describe methods/measures and then implement them in your audit, cover each audit component*

### 6.1 Ethical Considerations
[Content to be added]

### 6.2 Bias Assessment
[Content to be added]

### 6.3 Fairness Evaluation
[Content to be added]

### 6.4 Transparency Measures
[Content to be added]

<div style="page-break-after: always;"></div>

---

## 7. Summary and Recommendations

*Understandable to ML and non-ML but domain experts*

### 7.1 Key Findings
[Content to be added]

### 7.2 Clinical Implications
[Content to be added]

### 7.3 Recommendations for Implementation
[Content to be added]

### 7.4 Limitations and Future Work
[Content to be added]

<div style="page-break-after: always;"></div>

---

## 7.5 Other ML Studies on Alzheimer's

### 7.5.1 Literature Review
[Content to be added]

### 7.5.2 Comparative Analysis
[Content to be added]

### 7.5.3 Positioning of Current Work
[Content to be added]

<div style="page-break-after: always;"></div>

---

## 8. Appendix I: Team Contributions

*Summary of each team member contributions (max 1/2 page per member)*

### 8.1 Victoria Barnett (Team Lead)
[Content to be added]

### 8.2 Ahmad Harris
[Content to be added]

### 8.3 Juan Mora
[Content to be added]

<div style="page-break-after: always;"></div>

---

## 9. Appendix II: Code Used for ML Experiments

*Code in PDF format*

[Code content to be added - reference to separate code documentation]

<div style="page-break-after: always;"></div>

---

## 10. Appendix III: AI Usage

*Describe and self-assess related GenAI usage for getting help on the project*

### 10.1 AI Tools Used
[Content to be added]

### 10.2 Purpose and Scope of AI Assistance
[Content to be added]

### 10.3 Self-Assessment of AI Usage
[Content to be added]

<div style="page-break-after: always;"></div>

---

## 11. References

[References to be added in appropriate academic format]
