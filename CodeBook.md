# Getting and Cleaning Data Course Project CodeBook

### This file describes the variables, data and any transformations and steps that were performed to clean up the data.  

The data for this project was obtained from:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script performs the following steps to clean the data:

* Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder into trainData, trainLabel and trainSubject.       
* Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder into testData, testLabel and testsubject.  
* Concatenate testData and trainData to data frame joinedData
* Concatenate testLabel and TrainLabel to data frame joinedLabel
* Concatenate testSubject to trainSubject to data frame joinedSubject.  
* read features.txt and extract ids for mean and standard deviation to idextract
* apply join of joinedData with idextract so we are left only with standard deviation and means and store it in filteredData
* remove () from descriptions and capitalize mean, rename std to SD for standard deviation in fliteredData
* read activity_labels.txt and remove underscores.
* lowercase everything and uppercase letter 8 in col2 rows 2 and 3 so walkinUpstairs and walkingDownstairs is better to read.
* create a vector of activitylabels matched by ID from joinedLabel dataframe and activity dataframe
* apply activityLable vector to joinedLabel column 1 so we now have activity names instead of IDs, and assign it the title activity
* give title "subject" to joinedSubject DF and column bind joinedSubject, joinedLabel and filteredData to dataframe "cleanedData". Write the table to file as "merged_data.txt"
* generate a second data set with the average of each measurement for each activity and each subject. 
* for each combination, calculate the mean of each measurement with the corresponding combination
* write result to "data_with_means.txt"
