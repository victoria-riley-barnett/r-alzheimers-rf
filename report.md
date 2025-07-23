# CSC 659-859 Summer 2025 Team Project Phase I

## Alzheimer's Diagnosis Assistance with Random Forest

**Date:** 07/07/2024

**Team Number:** 04
- **Victoria Barnett** | Team Lead | rbarnett@sfsu.edu
- **Ahmad Harris**
- **Juan Mora**

---

## 1. Executive Summary 
*(1 page max)*

[Content to be added]

<div style="page-break-after: always;"></div>

---

## 2. Motivation, Problem Description and Case Study Goals

[Content to be added]

<div style="page-break-after: always;"></div>

---

## 3. Data

*Choose, describe and audit the data to be used – description, analysis, full database audit and analysis etc. – use class slides as guidance*

### 3.1 Data Description
[Content to be added]

### 3.2 Data Analysis
[Content to be added]

### 3.3 Database Audit
Our data statistics include 2,149 samples with 35 features and 2 classes that determine whether or not a patient is diagnosed with Alzheimer’s. The Diagnosis feature uses class label 0 for no presence of Alzheimer’s and class label 1 for presence of Alzheimer’s. There are 1,389 samples with class label 0 and 760 samples with class label 1. The data is not unbalanced, as each class label has more than 10% of samples associated with it. Since we are working with tabular data, our data format is applicable for the ML we will use, which is Random Forest. The dataset has no missing features. The types of features included in the dataset are numerical (SystolicBP: Systolic blood pressure, ranging from 90 to 180 mmHg.), categorical (Depression: Presence of depression, where 0 indicates No and 1 indicates Yes.), and nominal (Ethnicity: The ethnicity of the patients, coded as follows: 0: Caucasian; 1: African American; 2: Asian; 3: Other). In terms of obtaining the dataset, our dataset is synthetic. This means there are no privacy issues involved in our dataset. There are enough samples compared to features, seeing that there are over 2,000 samples and 35 features. Demography in the dataset covers an age range from 60 to 90 years with the Age feature. Gender is covered with its own feature that uses label 0 for Male and label 1 for Female. Ethnicity is also covered with its own feature, having label 0 represent Caucasian, label 1 represent African American, label 2 represent Asian, and label 3 represent Other. EducationLevel is also considered with label 0 representing no education level, label 1 representing High School, label 2 representing Bachelor’s, and label 3 representing a higher education level. The goal of our ML decision is to be able to provide a probabilistic assessment for a patient having Alzheimer’s disease. There is not much risk involved, as a high probabilistic assessment would only require following up on more examinations conducted by a clinician to determine whether the patient actually has Alzheimer’s.

<div style="page-break-after: always;"></div>

---

## 4. ML Methods

*Describe RF methods to be used with chosen data using SciKit or R - follow ML best practices as in HW 2*

### 4.1 Tools and Methods Used
[Content to be added]

### 4.2 Parameters for Setup
[Content to be added]

### 4.3 Training Methodology
[Content to be added]

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
