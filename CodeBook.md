# Description of variables and transformations used in the code
#### 1. Initially the paths for the different files to be read, have been generated with the "paste" function. The varaible x was 
passed as an argument to the function. This string variable has the name of the folder in which the downloaded data is saved in 
the working directory.
#### 2. The variables filename, filename1_test, filename2_test, filename3_test, filename1_train, filename2_train, filename3_train
have the paths for files features.txt, subject_test.txt, X_test.txt, y_test.txt, subject_train.txt, X_train.txt, y_train.txt 
respectively.
#### 3. Variables a,b are used to create connections to subject_test.txt, y_test.txt respectively. These connections are used to 
read the files into dataframes dft1 & dft2. X_test.txt is read as table in variable c and dft1,dft2,c are combined using cbind 
function in the variable d1.
#### 4. The same procedure is used to extract the train dataset in d1 variable.
#### 5. d1 & d2 are combined using rbind function into d3 variable. The variable names of the 561 variables is extracted and saved 
in variable names replace. d4 variable is used to store the final variable with 561 variables, subject IDs and activity IDs.
#### 6. The merged data set is saved in the working directory as merged_data.csv. This step is optional, carried out to track 
changes. 
#### 7. The activity IDs and their corresponding activity labels are stored in variable Activity_list. This variable is used to 
replace activity IDs such as 1,2,3 etc. by WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS etc. respectively.
#### 8. The column names with variable names containing "mean" and "std" are extracted using "grep" function. The final extracted 
dataset with only the columns computing mean and standard deviation with the activity labels replaced is stored in extract_data 
varaible.
#### 9. Using Subsetting first the rows corresponding to a particular subject and activity are extracted and saved in x1 and using 
the mapply function the mean for all the columns is calculated. 
#### 10. This list is coerced as vector and saved as a row of matrix m. Corresponding subject ID is saved in subject_ID vector
and Activity label is saved in activity_label vector. The column names for m matrix are changed to reflect the column names of the
dataset.
#### 11. Finally subject_ID, activity_label and m are combined into one variable d1 and using write.table() function the datset is 
written into a text file final_cleandata.txt. 
#### Note: The code has been inserted with print()function to print the message indicating the completion of a step. After every 
major step the variables used in the step have been removed using rm function for optimizing the space used to run the code.
