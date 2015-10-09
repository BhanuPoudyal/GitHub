library(plyr)
setwd("UCI HAR Dataset")
dir()

#Step 1: Merges the training and the test sets to create one data set.

#Extracting and examining data
xTestData<-read.table("test/x_test.txt")
head(xTestData)
yTestData<-read.table("test/y_test.txt")
head(yTestData)
subjectTestData<-read.table("test/subject_test.txt")
head(subjectTestData)
xTrainData<-read.table("train/x_train.txt")
head(xTrainData)
yTrainData<-read.table("train/y_train.txt")
head(yTrainData)
subjectTrainData<-read.table("train/subject_train.txt")
head(subjectTrainData)

#Combinin gtraining and testing set
xCombine<-rbind(xTestData, xTrainData)
yCombine<-rbind(yTestData, yTrainData)
subjectCombine<-rbind(subjectTestData, subjectTrainData)

#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
#As mean and standard deviations are recorded in features.txt file, this data is extracted and examined below
features<-read.table("features.txt")
head(features)
str(features)
meanNStd <- grep("-(mean|std)\\(\\)", features[, 2])
#Subsetting x data with only mean and std features only 66 out of 561 parameters selected
xCombineNew<-xCombine[, meanNStd]
#Assign correct column names
names(xCombineNew)<-features[meanNStd, 2]

#Step 3: Uses descriptive activity names to name the activities in the data set
# Get activities
activities <- read.table("activity_labels.txt")
# Update Y data with activity names
yCombine[, 1] <- activities[yCombine[, 1], 2]
names(yCombine)<-"Activity"

#Step 4: Appropriately labels the data set with descriptive variable names
#Give appropriate variable name to the only variable in Subject data 
names(subjectCombine)<-"subject"
#Add y data and subject data to x data to create single dataset
xYSubjectCombined<-cbind(xCombineNew, yCombine, subjectCombine)

#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
ncol(xYSubjectCombined)
#There are 68 variables, 66 from x data and one each from activity data and subject data. 
#As activities and subject are non-aditive variables, mean of one to 66 variables is calculated.
meanofAll <- ddply(xYSubjectCombined, .(subject, Activity), function(x) colMeans(x[, 1:66]))
#Create second independent tidy dataset from mean of all
write.table(meanofAll, "averages_data.txt", row.name=FALSE)

