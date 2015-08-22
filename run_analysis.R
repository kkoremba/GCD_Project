#setwd("C:/Users/Krzysiek/Documents/Nauka R/GCD/")


## downloading files
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "project_data.zip")
unzip("project_data.zip")


## reading train data

s_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject_ID"))
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("action_ID")) 

## reading test data

s_test <- read.csv("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject_ID"))
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("action_ID")) 


## reading features names
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("feature_ID", "feature_name"))


## 1. Merging the training and the test sets to create one data set.

## renaming features to descriptive names
names(x_train) <- features[,2]
names(x_test) <- features[,2]

sxy_train <- cbind(s_train, y_train, x_train)

s2_test <- rbind(s_test, vector(length = 1))
s2_test[2947,1] <- NA
sxy_test <- cbind(s2_test, y_test, x_test)

data_1 <- rbind(sxy_train, sxy_test)


#2.Extracting only the measurements on the mean and standard deviation for each measurement.

col_mean <- grep("-mean()", names(data_1), fixed = T)
col_std <- grep("-std()", names(data_1), fixed = T)
col_selected <- union(union(col_mean, col_std), c(1,2))

data_2 <- data_1[, col_selected]


#3.Using descriptive activity names to name the activities in the data set

activity_labels = read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("action_ID", "action_label"))

data_3 <- merge(data_2, activity_labels)


#4.Appropriately labels the data set with descriptive variable names. - that's already done in # 1

#5.From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.


data_5 <- aggregate(x = data_3, by = list(action_label = data_3$action_label, subject_ID = data_3$subject_ID), mean)
data_5 <- data_5[,-71]

write.table(file = "tidy.txt", x = data_5, row.names = F) 
   
 