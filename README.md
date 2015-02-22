# GettingAndCleaningData - CourseProject
Repository to upload the work done for the Course Project of the Coursera's and Johns Hopkins Getting and Cleaning Data course

#How the script works

The script works in 5 steps:
1. Merge the training data and test sets to create one data set
--*We read the data assuming the working directory contains a directory named "UCI HAR Dataset" where the Samsung data resides
--*The train and test data is merged in this step using the join function
2. Extract only the measurements on the mean and standard deviation of each measurement
--*Using the read.table function, we get the features table, using the grep function we extract only the mean and standard deviation columns from the feature file, select only the columns that correspond to this two columns in the data set and finally name the data set columns
3. Use descriptive activity names to name the activities in the data set
--*By leveragint the activity_labels txt file, we categorize this into a table with the "Activity" header, which contains the ActivityId that will be later used to join the data and the appropiate activity name
4. Appropiately label the data set with descriptive variable names
--*We start by labeling the subject data as "Subject", then CBinding the 3 data sets (the X, Y and Subject data) and finally we perform some cleanup by replacing some strings from the column header names with something more meaningful. i.e. "Acc" is replaced by "Acceleration" and "Gyro" by "AngularSpeed"
5. We finalize the script by generating the tidy dataset using the ddply function and, using our joined data set, specify grouping by Subject and Activity, and passing a function to calculate the mean of each column from 1:66, which is number of columns we want to calculate in our data set. Once this data set has been produced, we create the result file using the write.table function, specifying the parameter row.name as FALSE as per the project's requirements.