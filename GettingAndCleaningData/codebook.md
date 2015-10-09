---
title: "Code Book"
author: "Bhanu Poudyal"
date: "October 8, 2015"
output: html_document

## Source Files and Variables

The analysis done in accompanied `run_analysis.R` code file uses `x_test.txt`, `y_test.txt`, `subject_test.txt`, `x_train.txt`, `y_train.txt`, `subject_train.txt`, `features.txt`, and `activity_labels.txt` files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. Both the training dataset x_train and testing dataset X_test data have 561 variables. Y_data has activity numbers witch correspond to activity labels listed in activity_labels.txt file. Subjects of this study are listed in subject test and train data. The 561 features are listed in features.txt file

## Data Processing
The data from the files read to following data frames as shown in code below:
```{r, echo=TRUE, eval=FALSE}
xTestData<-read.table("test/x_test.txt")
yTestData<-read.table("test/y_test.txt")
subjectTestData<-read.table("test/subject_test.txt")
xTrainData<-read.table("train/x_train.txt")
yTrainData<-read.table("train/y_train.txt")
subjectTrainData<-read.table("train/subject_train.txt")
features<-read.table("features.txt")
activities <- read.table("activity_labels.txt")
```

As we are interested in only mean and standard deviation, these variables are selected as shown in code below:

```{r, echo=TRUE, eval=FALSE}
meanNStd <- grep("-(mean|std)\\(\\)", features[, 2])
```

Training and testing datasets  are combined to single data frames for each of data types as shown in code below:

```{r, echo=TRUE, eval=FALSE}
xCombine<-rbind(xTestData, xTrainData)
yCombine<-rbind(yTestData, yTrainData)
subjectCombine<-rbind(subjectTestData, subjectTrainData)
```

Combined datasets are subsetted by means and standard deviation and assigned correct names to them as shown in code below:

```{r, echo=TRUE, eval=FALSE}
xCombineNew<-xCombine[, meanNStd]
names(xCombineNew)<-features[meanNStd, 2]
```
Combined activity numbers (y data) are updated with activity names as shown below:
```{r, echo=TRUE, eval=FALSE}
yCombine[, 1] <- activities[yCombine[, 1], 2]
names(yCombine)<-"Activity"
```

Then applied appropriate variable name for subjects and subjects and activities are applied with combination of training and testing data (x data) as shown in code below:

```{r, echo=TRUE, eval=FALSE}
ynames(subjectCombine)<-"subject"
xYSubjectCombined<-cbind(xCombineNew, yCombine, subjectCombine)

```

Finally, average of all variables are calculated and written them to a file called `averages_data.txt`

```{r, echo=TRUE, eval=FALSE}
meanofAll <- ddply(xYSubjectCombined, .(subject, Activity), function(x) colMeans(x[, 1:66]))
write.table(meanofAll, "averages_data.txt", row.name=FALSE)
