##Code Book


###Data source
Data was collected from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

###Data transformation

  1.  Reading data:

  `s_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject_ID"))`
  `x_train <- read.table("UCI HAR Dataset/train/X_train.txt")`
  `y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("action_ID"))` 
  `s_test <- read.csv("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject_ID"))`
  `x_test <- read.table("UCI HAR Dataset/test/X_test.txt")`
  `y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("action_ID"))` 
  `features <- read.table("UCI HAR Dataset/features.txt", col.names = c("feature_ID", "feature_name"))`

  2.  Renaming features in x_train and y_train with feature names from *features* data set
  3.  Merging subject id, action id and feature values with *cbind()* function. For s_test set I had to add one row. At this part I have two datasets with subject Id, action Id and feature vector. Finally I concatenate train and test data with *rbind()* function
  4.  Extracting only the measurements on the mean and standard deviation for each measurement. I use *grep()* function to select features with name containing *mean()* and *std()*. I also add subject Id and action Id.
  5.  Using descriptive activity names to name the activities in the data set. I use *merge()* function to join activity labels
  6.  From the previoius data set - creating a second, independent tidy data set with the average of each variable for each activity and each subject. I use *aggregate()* function to summarize data.

  
