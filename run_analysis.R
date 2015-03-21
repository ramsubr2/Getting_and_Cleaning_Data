library(data.table)
library(dplyr)

# Data files are in current working directory

####Merges the training and the test sets to create one data set.

#Read the training and text data files and merge them to create one dataset
train_data_tbl <- read.table("./X_train.txt")
test_data_tbl <- read.table("./X_test.txt")
merged_data_tbl <- merge(train_data_tbl, test_data_tbl, all = TRUE)

###Extracts only the measurements on the mean and standard deviation for each measurement. 

#Read the features.txt file to get Variable names for the columns in the merged data set
features_tbl <- read.table("./features.txt")

# Replace column names in merged data set
colNames <- NULL
numVariables <- nrow(features_tbl)
for (i in 1:numVariables) {
  colNames <- c(colNames, as.character(features_tbl[i,2]))
}
colnames(merged_data_tbl) <- colNames

#eliminating duplicate column names - 84 columns should be eliminated as duplicates
merged_data_tbl <- merged_data_tbl[,!duplicated(colnames(merged_data_tbl))]
#convert to dplyr table
merged_data_tbl_p <- tbl_df(merged_data_tbl)

#extract only mean and std from the measurements - 86 columns have mean and std measurements
mean_std_only_tbl <- select(merged_data_tbl_p, contains("-mean"), contains("-std"), contains("Mean"))

###Uses descriptive activity names to name the activities in the data set

#Read the training and test subject files and merge them into one
train_subject_tbl <- read.table("./subject_train.txt")
test_subject_tbl <- read.table("./subject_test.txt")
merged_subject_tbl <- rbind(train_subject_tbl, test_subject_tbl)

#Read the training and test activity files and merge them into one
train_activity_tbl <- read.table("./y_train.txt")
test_activity_tbl <- read.table("./y_test.txt")
merged_activity_tbl <- rbind(train_activity_tbl, test_activity_tbl)

# make the activity names descriptive
activities_tbl <- read.table("./activity_labels.txt")
activities_tbl[,2] = gsub("_", " ", tolower(as.character(activities_tbl[,2])))
names(merged_activity_tbl) <- "Activity"
merged_activity_tbl[,1] = activities_tbl[merged_activity_tbl[,1],2]

###Appropriately labels the data set with descriptive variable names. 
names(merged_subject_tbl) <- "Subject"
tidy_tbl = cbind(merged_subject_tbl, merged_activity_tbl,mean_std_only_tbl)

# write the cleaned up data set
write.table(tidy_table, "mean_std_only_tidy.txt")
