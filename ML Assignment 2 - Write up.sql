
1. Import data & Variable definition 
------------------------------------
Import data 
Replace 999 with nulls
Split clinical & MRI features
	clf_output_column_name = "pCR (outcome)"
	reg_output_column_name = "RelapseFreeSurvival (outcome)"

features_continuous = ["Age"] + MRI_features
features_categorical = list(set(features) - set(features_continuous))

2. Exploratory Data Analysis 
------------------------------------
PCR is unbalanced (Low count of 1)
RFS has follows a normal distribution although it has many dips in bins close to the mean. Few outliers close to 140 months are observed increasing the dispersion in target variable. 

Replace 999 with nulls
For missing continuous features - Replace missing values in upper and lower bound with median value 
Used KNN to impute missing values in categorical values 

Compare distribution of clinical data before and after imputation using histograms 
Compare distribution of MRI features before and after imputation using Gaussian distributions - Imputed values can be seen to deviate vs pre-imputed values for features with missing values 

Study multi-collinearity across all features 

3. Model development 
------------------------------------

Data pre-processing - Outlier treatment & Scaling 
	Modified Z-score used to identify outliers 
	Impute outliers for continuous features with median 
	Normalize continuous features 
	KNN Imputer to replace Nulls in categorical features  
	
Feature selection test 
	T Test 
	Pearson correlation 
	Dimensionality reduction with PCA 
	Nested K-fold validation using stratified folds 

i. Classification - Target Variable: PCR  
----------------------------------------

Nested K-fold cross validation for Classification
-------------------------------------------------

SVC 
------
--Find best preprocess setting for preocessed data 

IQR / Zscore comparison // with and without PCA // Pearson vs T Test 

iqr | ttest | with PCA
F1 Mean ± Standard: (88.20 ± 1.72)%
Balance Acc Mean ± Standard: (50.53% ± 1.05)%
Accuracy Mean ± Standard: (78.99% ± 2.73)%

zscore | corr | without PCA
F1 Mean ± Standard: (88.20 ± 1.72)%
Balance Acc Mean ± Standard: (50.53% ± 1.05)%
Accuracy Mean ± Standard: (78.99% ± 2.73)%

a. Logistic Reegression 
------
F1 Mean ± Standard: (86.03 ± 2.42)%
Balance Acc Mean ± Standard: (53.04% ± 4.47)%
Accuracy Mean ± Standard: (76.20% ± 3.70)%

b. Decision Tree 
------
F1 Mean ± Standard: (87.11 ± 2.58)%
Balance Acc Mean ± Standard: (50.37% ± 1.15)%
Accuracy Mean ± Standard: (77.47% ± 3.70)%

c. Random Forest 
------
F1 Mean ± Standard: (87.75 ± 2.11)%
Balance Acc Mean ± Standard: (51.37% ± 2.28)%
Accuracy Mean ± Standard: (78.48% ± 3.20)%

d. Neural Network - MLPClassifier 
------
F1 Mean ± Standard: (85.08 ± 3.23)%
Balance Acc Mean ± Standard: (53.97% ± 4.57)%
Accuracy Mean ± Standard: (75.19% ± 4.28)%

e. XGBoost 
------
F1 Mean ± Standard: (85.49 ± 3.12)%
Balance Acc Mean ± Standard: (57.04% ± 5.76)%
Accuracy Mean ± Standard: (75.95% ± 4.87)%

f. LGBMClassifier  
------
F1 Mean ± Standard: (85.88 ± 0.62)%
Balance Acc Mean ± Standard: (55.01% ± 2.51)%
Accuracy Mean ± Standard: (76.20% ± 0.95)%

h. ElasticNet 
------
F1 Mean ± Standard: (86.07 ± 2.44)%
Balance Acc Mean ± Standard: (52.48% ± 3.40)%
Accuracy Mean ± Standard: (76.20% ± 3.70)%


-->> RANDOM FOREST YIELDS BEST RESULT 


ii. Regression - Target Variable: RFS  
----------------------------------------

Nested K-fold cross validation for Regression
-------------------------------------------------

SVR 
--------
--Find best preprocess setting for preocessed data 


a. Linear Regression 
--------

MSE Mean ± Standard: 854.07 ± 96.68
RMSE Mean ± Standard: 29.18 ± 1.64
MAE Mean ± Standard: 23.53 ± 1.60

b. SVR
--------
MSE Mean ± Standard: 728.73 ± 37.23
RMSE Mean ± Standard: 26.99 ± 0.69
MAE Mean ± Standard: 21.19 ± 0.91

c. DecisionTree Regressor 
--------
MSE Mean ± Standard: 735.20 ± 60.17
RMSE Mean ± Standard: 27.09 ± 1.10
MAE Mean ± Standard: 21.15 ± 1.02

d. Random Forest Regressor 
--------
MSE Mean ± Standard: 720.73 ± 40.33
RMSE Mean ± Standard: 26.84 ± 0.75
MAE Mean ± Standard: 21.07 ± 0.90

e. MLP Regressor 
--------
MSE Mean ± Standard: 1097.94 ± 118.93
RMSE Mean ± Standard: 33.09 ± 1.82
MAE Mean ± Standard: 26.05 ± 1.77

f. XG Boost Regressor 
-------
MSE Mean ± Standard: 832.82 ± 132.84
RMSE Mean ± Standard: 28.76 ± 2.33
MAE Mean ± Standard: 22.36 ± 1.81

g. LGBM Regressor 
--------
MSE Mean ± Standard: 762.14 ± 108.46
RMSE Mean ± Standard: 27.53 ± 2.01
MAE Mean ± Standard: 21.87 ± 1.41

h. Elastic Net 
--------
MSE Mean ± Standard: 717.47 ± 49.79
RMSE Mean ± Standard: 26.77 ± 0.93
MAE Mean ± Standard: 21.26 ± 1.10



4. Model Evaluation 
-------------------------------------------

a. Comparison of all classification models 
---------------------------------------
Logistic Regression
F1 Mean ± Standard: (86.03 ± 2.42)%
Balance Acc Mean ± Standard: (53.04% ± 4.47)%
Accuracy Mean ± Standard: (76.20% ± 3.70)%

SVC
F1 Mean ± Standard: (88.07 ± 1.83)%
Balance Acc Mean ± Standard: (50.00% ± 0.00)%
Accuracy Mean ± Standard: (78.73% ± 2.93)%

Decision Tree
F1 Mean ± Standard: (87.11 ± 2.58)%
Balance Acc Mean ± Standard: (50.37% ± 1.15)%
Accuracy Mean ± Standard: (77.47% ± 3.70)%

Random Forest
F1 Mean ± Standard: (88.07 ± 1.83)%
Balance Acc Mean ± Standard: (50.00% ± 0.00)%
Accuracy Mean ± Standard: (78.73% ± 2.93)%

MLP
F1 Mean ± Standard: (86.20 ± 2.51)%
Balance Acc Mean ± Standard: (51.21% ± 2.88)%
Accuracy Mean ± Standard: (76.20% ± 3.87)%

XGBoost
F1 Mean ± Standard: (85.49 ± 3.12)%
Balance Acc Mean ± Standard: (57.04% ± 5.76)%
Accuracy Mean ± Standard: (75.95% ± 4.87)%

Light GBM
F1 Mean ± Standard: (85.88 ± 0.62)%
Balance Acc Mean ± Standard: (55.01% ± 2.51)%
Accuracy Mean ± Standard: (76.20% ± 0.95)%

Elastic Net
F1 Mean ± Standard: (86.07 ± 2.44)%
Balance Acc Mean ± Standard: (52.48% ± 3.40)%
Accuracy Mean ± Standard: (76.20% ± 3.70)%

-->> XG Boost model selected for prediction 

b. Comparison of all Regression models 
---------------------------------------

Linear Regression
MSE Mean ± Standard: 854.07 ± 96.68
RMSE Mean ± Standard: 29.18 ± 1.64
MAE Mean ± Standard: 23.53 ± 1.60

SVC
MSE Mean ± Standard: 724.73 ± 34.52
RMSE Mean ± Standard: 26.91 ± 0.64
MAE Mean ± Standard: 21.11 ± 0.82

Decision Tree
MSE Mean ± Standard: 735.20 ± 60.17
RMSE Mean ± Standard: 27.09 ± 1.10
MAE Mean ± Standard: 21.15 ± 1.02

Random Forest
MSE Mean ± Standard: 714.77 ± 47.14
RMSE Mean ± Standard: 26.72 ± 0.88
MAE Mean ± Standard: 21.02 ± 0.96

MLP
MSE Mean ± Standard: 1097.94 ± 118.93
RMSE Mean ± Standard: 33.09 ± 1.82
MAE Mean ± Standard: 26.05 ± 1.77

XGBoost
MSE Mean ± Standard: 832.82 ± 132.84
RMSE Mean ± Standard: 28.76 ± 2.33
MAE Mean ± Standard: 22.36 ± 1.81

Light GBM
MSE Mean ± Standard: 762.14 ± 108.46
RMSE Mean ± Standard: 27.53 ± 2.01
MAE Mean ± Standard: 21.87 ± 1.41

Elastic Net
MSE Mean ± Standard: 717.47 ± 49.79
RMSE Mean ± Standard: 26.77 ± 0.93
MAE Mean ± Standard: 21.26 ± 1.10

-->> Elastic Net is chosen for prediction 

5. Model Evaluation 
-----------------------------

-->> XG Boost model selected for prediction 
-->> Elastic Net is chosen for prediction 



6. Prediction using Test data
-----------------------------


































 





 

