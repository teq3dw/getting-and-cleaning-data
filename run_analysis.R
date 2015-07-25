library(dplyr)

# read training data
trainData <- read.table("./data/train/X_train.txt")
trainLabel <- read.table("./data/train/y_train.txt")
trainSubject <- read.table("./data/train/subject_train.txt")

#read test data
testData <- read.table("./data/test/X_test.txt")
testLabel <- read.table("./data/test/y_test.txt")
testSubject <- read.table("./data/test/subject_test.txt")

#join datasets
joinedData <- rbind(trainData, testData)
joinedLabel <- rbind(trainLabel, testLabel)
joinedSubject <- rbind(trainSubject, testSubject)


# extract mean and standard deviation for each measurement
features <- read.table("./data/features.txt")
idextract <- grep("mean\\(\\)|std\\(\\)", features[,2])

#filter joinedData dataframe by extracted indicies using inner join
filteredData <- joinedData[, idextract]

# get rownames from features table
names(filteredData) <- gsub("\\(\\)", "", features[idextract, 2]) # remove the () behind the mean and std
names(filteredData) <- gsub("mean", "Mean", names(filteredData)) # Capitalize Mean
names(filteredData) <- gsub("std", "SD", names(filteredData)) # rename std to SD for increased descriptiveness

#make descriptive labels for the joinedLabels DF
activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2])) # add index to first column, remove _ and lowercase everything
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2:3, 2], 8, 8)) # capitalize letter 8 in table position 2,2 (U in walkingUpstairs)
#substr(activity[2, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8)) # capitalize letter 8 in table position 3,2 (D in walkingDownstairs)
activityLabels <- activity[joinedLabel[,1], 2] # match activity description from df activity to df joinedlabel by ID
joinedLabel[, 1] <- activityLabels # join activitylabels character vector to joinedLabel df
names(joinedLabel) <- "activity"


#join label data with the subject the subject data with descriptive names and create cleanedData
names(joinedSubject) <- "subject"
cleanedData <- cbind(joinedSubject, joinedLabel, filteredData)

#write the requested text file merged_data.txt containing the cleaned dataset
write.table(cleanedData, "merged_data.txt") 


# create the second, independent tidy data set with averages of each variable for each activity and each subject.
#nosubjects <- length(table(joinedSubject))
#activitycount <- dim(activity)[1]
#columns <- dim(cleanedData)[2]
myres <- matrix(NA, nrow=length(table(joinedSubject))*dim(activity)[1], ncol=dim(cleanedData)[2]) # create a matrix with the reqiored dimensions
result <- as.data.frame(myres) # convert to dataframe
colnames(result) <- colnames(cleanedData)  # copy cleanedData column names to our result DF

myrow <- 1
for(i in 1:length(table(joinedSubject))){   # iterate through subjects (i)
  for(x in 1:dim(activity)[1]) {            # and through activities (x)
    result[myrow, 1] <- sort(unique(joinedSubject)[, 1])[i] # fill column 1 for current row with current subject
    result[myrow, 2] <- activity[x, 2]                      # fill column 2 for current activity 
    subjectmatch <- i == cleanedData$subject                  # current subject equals cleanedData$subject
    activitymatch <- activity[x,2] == cleanedData$activity    # current activity equals cleanedData$activity
    result[myrow, 3:dim(cleanedData)[2]] <- colMeans(cleanedData[subjectmatch&activitymatch, 3:dim(cleanedData)[2]]) # write data to result
    myrow <- myrow + 1 # iterate to next row
  }
}
write.table(result, "data_with_means.txt")



