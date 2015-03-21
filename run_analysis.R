library(data.table)
library(dplyr)

# All Data files are in current working directory
# Make sure you have installed the "data.table" and "dplyr" packages

#### 1. Merges the training and the test sets to create one data set.

#Read the training and text data files and merge them to create one dataset
print("Reading Training and Test data sets and Merging...")
train_data_tbl <- read.table("./X_train.txt")
test_data_tbl <- read.table("./X_test.txt")
merged_data_tbl <- rbind(train_data_tbl, test_data_tbl)

### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
print("Extracting only mean and standard deviation measurements...")
#Read the features.txt file to get Variable names for the columns in the merged data set
features_tbl <- read.table("./features.txt")

# Replace column names in merged data set
colNames <- NULL
numVariables <- nrow(features_tbl)
for (i in 1:numVariables) {
  colNames <- c(colNames, as.character(features_tbl[i,2]))
}
colnames(merged_data_tbl) <- colNames

#eliminating duplicate column names
merged_data_tbl <- merged_data_tbl[,!duplicated(colnames(merged_data_tbl))]
#convert to dplyr table
merged_data_tbl_p <- tbl_df(merged_data_tbl)
rm("merged_data_tbl") #since we don't need the original merged data table anymore

#extract only mean and std from the measurements - 86 columns have mean and std measurements
mean_std_only_tbl <- select(merged_data_tbl_p, contains("-mean"), contains("-std"), contains("Mean"))

### 3. Uses descriptive activity names to name the activities in the data set
print("Adding descriptive activity names to the merged data set...")
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

### 4. Appropriately labels the data set with descriptive variable names. 
names(merged_subject_tbl) <- "Subject"
tidy_tbl = cbind(merged_subject_tbl,merged_activity_tbl,mean_std_only_tbl)
tidy_tbl_p <- tbl_df(tidy_tbl)
rm("tidy_tbl") # since we don't need tidy table anymore

# write the cleaned up data set
print("Writing cleaned up data set with mean and std measurements...")
write.table(tidy_tbl_p, "mean_std_only_tidy.txt")

### 5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.
print("Creating a second tidy data set with averages for each activity and subject...")
tidy_tbl_by_subject_activity <- group_by(tidy_tbl_p, Subject, Activity)
tdy_tbl_avg_each_variable <- summarise_each(tidy_tbl_by_subject_activity,funs(mean))

#write this data set
print("Writing the data set 'avg_grouped_by_subject_activity.txt'...")
write.table(tdy_tbl_avg_each_variable, "avg_grouped_by_subject_activity.txt")

