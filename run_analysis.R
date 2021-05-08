# 1. Merge the training and the test sets to create one data set
# 1.1 Load packages
library(data.table)
library(dplyr)

# 1.2 Download dataset and unzip file
filename <- "Dataset.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists(filename)) {
  download.file(fileUrl,filename)
}
# Unzip file
if (!file.exists("UCI HAR Dataset")) {
  unzip(filename)
}

# 1.3. Assigning data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# 1.4. Merging data
mergeSubject <- rbind(subject_test, subject_train)
mergeX <- rbind(x_test,x_train)
mergeY <- rbind(y_test,y_train)
mergeData <- cbind(mergeSubject, mergeX, mergeY)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
tidyData <- mergeData %>% select(subject, code, contains("mean"), contains("std"))

# 3. Uses descriptive activity names to name the activities in the data set
tidyData$code <- activities[tidyData$code, 2]

# 4. Appropriately labels the data set with descriptive variable names. 
names(tidyData)[2] = "activity"
names(tidyData)<-gsub("Acc", "Accelerometer", names(tidyData))
names(tidyData)<-gsub("Gyro", "Gyroscope", names(tidyData))
names(tidyData)<-gsub("BodyBody", "Body", names(tidyData))
names(tidyData)<-gsub("Mag", "Magnitude", names(tidyData))
names(tidyData)<-gsub("^t", "Time", names(tidyData))
names(tidyData)<-gsub("^f", "Frequency", names(tidyData))
names(tidyData)<-gsub("tBody", "TimeBody", names(tidyData))
names(tidyData)<-gsub("-mean()", "Mean", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-std()", "STD", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-freq()", "Frequency", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("angle", "Angle", names(tidyData))
names(tidyData)<-gsub("gravity", "Gravity", names(tidyData))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
finalData <- tidyData %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean))
write.table(finalData, "finalData.txt", row.name=FALSE)