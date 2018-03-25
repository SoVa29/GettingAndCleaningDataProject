#Downloads and unzips data

#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "zipData.zip" )
if (!file.exists("UCI HAR Dataset")) { 
       unzip("zipData.zip") 
 }

#initial data prep
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)

# ***************************************************************************************
# 1. Merges the training and the test sets to create one data set.

# combine x, y and subject tables data
xData <- rbind(x_train, x_test)
yData <- rbind(y_train, y_test)
subjectData <- rbind(subject_train, subject_test)

names(xData) <- features[,2] # re-name xData
names(yData) <- "Activity"  # re-name yData
names(subjectData) <- "Subject"
combinedData <- cbind(xData, yData, subjectData)

# ***************************************************************************************
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# selects columns with mean and standard deviation
columnsMeanSTD <- c(as.character(features$V2 [grep("mean\\(\\)|std\\(\\)", features$V2)]))
# final data table with only mean and standard deviation
dataMeanSTD <- subset(combinedData, select = columnsMeanSTD)

# ***************************************************************************************
# 3. Use descriptive activity names to name the activities in the data set

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

#clean activity headers
names(activity_labels) <- c('activityID', 'activityName')
yData[, 1] = activity_labels[yData[, 1], 2]


# ***************************************************************************************
# 4. Appropriately label the data set with descriptive variable names.

#clean xData headers
names(xData) <- gsub("^f", "frequency", names(xData))
names(xData) <- gsub("^t", "time", names(xData))
names(xData) <- gsub("-mean()", "Mean", names(xData))
names(xData) <- gsub("mad", "Median", names(xData))
names(xData) <- gsub("-std", "StdDev", names(xData))
names(xData) <- gsub("Mag", "Magnitude", names(xData))
names(xData) <- gsub("Acc", "Accelerometer", names(xData))
names(xData) <- gsub("BodyBody", "Body", names(xData))

tidyData <- cbind(subjectData, xData, yData)

# ***************************************************************************************
# 5.Create an independent tidy data set with the average of each variable for each activity and each subject. 

finalData <- aggregate(. ~Subject + Activity, tidyData, mean)
finalData <- finalData[order(finalData$Subject,finalData$Activity),]

#write file
write.table(finalData, file = "tidydata.txt",row.name=FALSE)

