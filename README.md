# Cleandata Course Project
## Decsription of run_analysis.R script
#### This R code has been generated to perform the five tasks as defined in the project. These are as follows:
#### 1. The first task is to merge the "test" and the "train" datasets given in two separate folders. The test folder and train folder contain X_test.txt file and X_train.txt file respectively with the values of 561 variables. The corresponding subject IDs in subject_test.txt/ subject_train.txt and Activity IDs are in y_test.txt/ y_train.txt.
#### 2. From the features.txt file the variable names of 561 variables were extracted and substituted as column names.The column with variables calculating mean and standard deviation were extracted. 
#### 3. Using the activity_labels.txt file the activity IDs wre replaced by the activity labels such as LAYING, STANDING etc.
#### 4. The extracted dataset was sorted according to subject IDs and Activity Labels for ease of computation.
#### 5. Using the mapply function mean was calculated for all the variables related to a particular subject and activity label. This dataset was saved as table in a .txt file named final_cleandata.txt 
