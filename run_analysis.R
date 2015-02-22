library(plyr)

###############################################################################
# 1.- Merge the training and test sets to create one data set
###############################################################################
x_train <- read.table("UCI\ HAR\ Dataset/train/X_train.txt")
y_train <- read.table("UCI\ HAR\ Dataset/train/y_train.txt")
subject_train <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt")

x_test <- read.table("UCI\ HAR\ Dataset/test/X_test.txt")
y_test <- read.table("UCI\ HAR\ Dataset/test/y_test.txt")
subject_test <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt")
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)
###############################################################################
# 2.- Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################
features <- read.table("UCI\ HAR\ Dataset/features.txt")
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, mean_and_std_features]
names(x_data) <- features[mean_and_std_features, 2]
###############################################################################
# 3.- Use descriptive activity names to name the activities in the data set
###############################################################################
activities <- read.table("UCI\ HAR\ Dataset/activity_labels.txt")
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "Activity"
###############################################################################
# 4.- Appropriately label the data set with descriptive variable names
###############################################################################
names(subject_data) <- "Subject"
all_data <- cbind(x_data, y_data, subject_data)

#Cleanup
names(all_data) <- gsub('\\(|\\)',"",names(all_data), perl = TRUE)
names(all_data) <- make.names(names(all_data))
names(all_data) <- gsub('Acc',"Acceleration",names(all_data))

names(all_data) <- gsub('GyroJerk',"AngularAcceleration",names(all_data))
names(all_data) <- gsub('Gyro',"AngularSpeed",names(all_data))
names(all_data) <- gsub('Mag',"Magnitude",names(all_data))
names(all_data) <- gsub('^t',"TimeDomain.",names(all_data))
names(all_data) <- gsub('^f',"FrequencyDomain.",names(all_data))
names(all_data) <- gsub('\\.mean',".Mean",names(all_data))
names(all_data) <- gsub('\\.std',".StandardDeviation",names(all_data))
names(all_data) <- gsub('Freq\\.',"Frequency.",names(all_data))
names(all_data) <- gsub('Freq$',"Frequency",names(all_data))


###############################################################################
# 5.- Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################
averages_data <- ddply(all_data, .(Subject, Activity), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "averages_data.txt", row.name=FALSE)