if(!file.exists("./project")) {dir.create("./project")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileUrl, destfile = "./project/Dataset.zip", method = "curl")
unzip(zipfile = "./project/Dataset.zip", exdir = "./project")
path_rf <- file.path("./project", "UCI HAR Dataset")
files <- list.files(path_rf, recursive = TRUE)

##read Activity files
dataActivitytest <- read.table(file.path(path_rf, "test", "y_test.txt"), header = FALSE)
dataActivitytrain <- read.table(file.path(path_rf, "train", "y_train.txt"), header = FALSE)
##read Subject files
dataSubjecttest <- read.table(file.path(path_rf, "test", "subject_test.txt"), header = FALSE)
dataSubjecttrain <- read.table(file.path(path_rf, "train", "subject_train.txt"), header = FALSE)
##read Features files
dataFeaturestest <- read.table(file.path(path_rf, "test", "X_test.txt"), header = FALSE)
dataFeaturestrain <- read.table(file.path(path_rf, "train", "X_train.txt"), header = FALSE)
##merge the test and train set in order to create one data set
## binding rows 
dataActivity <- rbind(dataActivitytest, dataActivitytrain)
dataSubject <- rbind(dataSubjecttest, dataSubjecttrain)
dataFeatures <- rbind(dataFeaturestest, dataFeaturestrain)
##setting names to variables
names(dataSubject) <- c("Subject")
names(dataActivity) <- c("Activity")
dataFeaturesnames <- read.table(file.path(path_rf, "features.txt"), header = FALSE)
names(dataFeatures) <- dataFeaturesnames$V2
##binding columns
data1 <- cbind(dataActivity, dataSubject)
finaldf <- cbind(dataFeatures, data1)
head(finaldf)
##subsetting names of Features by measurements on mean and standard deviation
subsetdataFeaturesnames <- dataFeaturesnames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesnames$V2)]
##subsetting the data frame by the selected names of Features
names <- c(as.character(subsetdataFeaturesnames), "Subject", "Activity")
finaldf <- subset(finaldf, select = names)
str(finaldf)
##use descriptive activity names to name the activities in the data set
##read the descriptive activity
activitylabels <- read.table(file.path(path_rf, "activity_labels.txt"), header = FALSE)$V2
finaldf$Activity <- factor(finaldf$Activity, labels = activitylabels)
head(finaldf$Activity, 30)
##appropriately labels the data set with descriptive variable names
names(finaldf)<-gsub("^t", "time", names(finaldf))
names(finaldf)<-gsub("^f", "frequency", names(finaldf))
names(finaldf)<-gsub("Acc", "Accelerometer", names(finaldf))
names(finaldf)<-gsub("Gyro", "Gyroscope", names(finaldf))
names(finaldf)<-gsub("Mag", "Magnitude", names(finaldf))
names(finaldf)<-gsub("BodyBody", "Body", names(finaldf))
names(finaldf)
## Creating the second dataset containing the average of each variable for each activity and each subject
Data2<-aggregate(. ~Subject + Activity, finaldf, mean)
Data2<-Data2[order(Data2$Subject,Data2$Activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
