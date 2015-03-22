---
title: "Code Book for Course Project"
author: "Ramesh Subramanian"
date: "Saturday, March 21, 2015"
output: html_document
---
Source of the original data: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description for the data that was collected can be found at: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The R script run_analysis.R cleans up the data and writes out a tidy data table

Data Files:

1.  X_train.txt: Data measurements from subjects in the training population. Data     is in 7352 rows, 561 columns. Columns are labeled V1..V561
2.  X_test.txt: Data measurements from subjects in the test population. Data is in 2947 rows, 561 columns. Columns are labeled V1..V561
3.  features.txt: Variable (column) names for data in the X_train and X_test files. Data is in 561 rows, 2 columns. Variables names are: 

* tBodyAcc-mean()-X
* tBodyAcc-mean()-
* tBodyAcc-mean()-Z
* tBodyAcc-std()-X
* tBodyAcc-std()-Y
* tBodyAcc-std()-Z
* tBodyAcc-mad()-X
* tBodyAcc-mad()-Y
* tBodyAcc-mad()-Z
* tBodyAcc-max()-X
* ...
* ...

4.  subject_train.txt: Subjects in the training population. Values are between 1:30. Data is in 7352 rows, 1 column
5.  subject_test.txt: Subjects in the test population. Values are between 1:30. Data is in 2947 rows, 1 column
6.  activity_labels.txt: Activities (walking, walking upstairs, walking downstairs, sitting, standing, laying). Data is in 6 rows, 2 columns.
7.  y_train.txt: Activity ids (1:6) of activities corresponding to activity labels that the training population took part in. Data is in 7352 rows, 1 column.
8.  y_test.txt: Activity ids (1:6) of activities corresponding to activity labels that the test population took part in. Data is in 2947 rows, 1 column.

The output created is a tidy data table of 180 rows (30 subjects X 6 activities), and 88 columns. Column 1 is subject id (1:30), Column 2 is the activity (walking, walking upstairs, walking downstairs, sitting, standing, laying), columns 3..88 are averages of each variable for a subject and activity.

-------|---------|-------------------|-----------------|-----------------|
Subject|  Activity|  tBodyAcc-mean()-X|	tBodyAcc-mean()-Y|	tBodyAcc-mean()-Z| .....

1      |  laying	 |  0.2215982	   |   -0.040513953   | 	-0.11320355 |

1      |  sitting  |	0.2612376	   |  -0.001308288    | 	-0.10454418 |

30      | walking downstairs |	0.2831906 |	-0.017438390 |	-0.09997814 |

30      | walking upstairs	 | 0.2714156	| -0.025331170 |	-0.12469749 |
