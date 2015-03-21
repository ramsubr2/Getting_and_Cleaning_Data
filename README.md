---
title: "README to explain what run_analysis.R does"
author: "Ramesh Subramanian"
date: "Saturday, March 21, 2015"
---

This project has five distinct steps. I describe the data files, variables and transformations used in each step to achieve the desired end result. 

The file run_analysis.R contains all the R code required to carry out each step. All the data files required to run this script must be in the same directory as the script file. 

STEP 1: Read the training and text data files and merge them to create one dataset. 
train_data_tbl stores the data from "X_train.txt" file. This table has 7352 rows and 561 columns. Rows are numbered 1..7352, Columns are named V1..v561.
test_data_tbl stores the data from "X_test.txt" file. This table has 2947 rows and 561 columns. Rows are numbered 1..2947, Columns are named V1..v561.
merged_data_tbl stores the merged (but not tidy) data set. This table has 10299 rows and 561 columns. The merge is accomplished with the rbind function. Rows are numbered 1..10299, Columns are named V1..v561.

STEP 2: Extract only the measurements on the mean and standard deviation for each measurement. 

2A. We need the column names. This is in the "features.txt" file. The column names are read into a table called features_tbl. This table has 561 rows and 2 columns. We have to replace the column names in the merged_data_tbl (from STEP 1) with the column names in the features_tbl. This is done by building a vector of the coulmn names and using the colnames() function to replace the column names

2B. Ok, we now have all the column names for the 561 columns in the merged_data_tbl. But some of these are duplicate names, so we have to eliminate duplicate column names.We can use the duplicated() function with colnames() to find and eliminate all duplicate columns. We store the data back into the merged_data_tbl which now has 10299 rows and 477 columns (84 columns were identified as duplicates).

2C. Now we extract only the columns which have mean or standard deviation measurements. We can convert our merged_data_tbl to a dplyr table and use the select() function with contains() to select only the required columns. We store the result in a new table called mean_std_only_tbl. This table has 10299 rows and 86 columns.

STEP 3. Add descriptive activity names to name the activities in the data set

3A. Subjects (or participants) are numbered 1..30. We create the two subject files "subject_train.txt" and "subject_test.txt" and merge them into one table merged_subject_tbl. This table has 10299 rows and 1 column.
3B. The "activity_labels.txt" file lists the 6 activities that the participants took part in. This is read into the activities_bl. The "y_train.txt" and "y_test.txt" files have the activity ids (1..6) corresponding to each row in the data files (STEP 1). We read and merge the two files into one table merged_activity_tbl. This table has 10299 rows and 1 column.
3C. Next we replace the numeric ids for the activities (1:6) in the merged_activity_tbl with the activity names from the activities_tbl.

STEP 4. Appropriately labels the data set with descriptive variable names. 
We name the column in the merged_activity_tbl as "Activity" and the column in the merged_subject_tbl as "Subject". Then we merge the merged_subject_tbl, merged_activity_tbl and the mean_std_only_tbl to create a clean version of the data set. This table is called tidy_tbl and has 10299 rows and 88 columns (86 columns with mean or std measurements, 1 column with subjects, 1 with activities). tidy_tbl has all the column(variable) names labeled with descriptive names.

STEP 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Almost there! We convert the tidy_tbl to a dplyr table. Then use group_by() to group the rows by subject and activity and store this in a table tidy_tbl_by_subject_activity. Finally use the summarise_each() function on the tidy_tbl_by_subject_activity table to calculate the mean for each subject by activity. This table is called tdy_tbl_avg_each_variable. This table has 180 rows (30 subjects taking part in 6 activities each) and 88 columns (1 subject, 1 activity, 86 columns of average values for mean or std).

Finally use write.table() to write this tidy table of average values to the file "avg_grouped_by_subject_activity.txt""

