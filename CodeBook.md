# Introduction

The script `run_analysis.R` is used to calculate the mean and standard deviation of Samsung data for a wearable device (a Samsung Galaxy S2 according to the page's source documentation) and then it is cleaned to provide meaningful information about the variables it exposes

* First, all the test and training data is merged using the `rbind()` function. As they were extracted from the same source, the columns are in the same order and represent the same variables of each observation.
* The next step is selecting only the data we want to work with, in this case, the standard deviation and the mean of each observation across all the variables in the data set.
* Then, using the file 'activity_data.txt', that contains the appropiate names for each activity type, we join this data in order to get the correct names into our data set and not only the id associated with them.
* Next, a general cleanup of the column header names is done, we proceed to remove parenthesis and some shortened variable names encountered while filtering the data
* As the last step, we proceed to generate a tidy data set with only the Subject and Activity Type. The result file, 'averages_data.txt', can be found in this same repository.

# Variables

* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` are generated using the read.table function by passing the downloaded data from the course project page.
* `x_data`, `y_data` and `subject_data` are the merged data from the previosly mentioned data sets, which were separated for the experiment purposes but that we need in one single data set.
* The 'features' variable is created by loading the 'features.txt' file and contains the column names that the data represents
* The 'activities' variable is created in a similar fashion, and it contains the appropiate name sof the activities that were captured during the experiment and that we will use to group the observations for our calculations
* The 'all_data' variable is a merge of all the data variables, and its created in order to be used to calculate the means of each observation.
* The 'averages_data' variable is created with a subset of columns from the 'all_data' variable, by grouping the data by the Subject and Activity columns and calculating the means of each of its columns, using the ddply function, which was loaded at the beginning of the script.