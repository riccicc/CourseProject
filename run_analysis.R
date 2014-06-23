## Course Project
## ------------------------------------------------------------------ 
## Developed on MS Windows 7 Professional, 32-bit Operating System
## RStudio Version 0.98.501
## R version 3.1.0 (2014-04-10)
## ------------------------------------------------------------------
## File Name: run_analysis.R
## ------------------------------------------------------------------

##install.packages("Hmisc")
##library(RCurl)
library(Hmisc)
library(plyr)
library(reshape2)

## assumption that the data text files are unzipped and in 
## a sub-directory titled 'CourseProject' under the R working directory. 

testData <- read.table(".\\CourseProject\\X_test.txt",stringsAsFactors=FALSE)
testTrain <- read.table(".\\CourseProject\\X_train.txt", stringsAsFactors=FALSE)
y_train <- read.table(".\\CourseProject\\y_train.txt", stringsAsFactors=FALSE)
y_test <- read.table(".\\CourseProject\\y_test.txt", stringsAsFactors=FALSE)
subject_train <- read.table(".\\CourseProject\\subject_train.txt", stringsAsFactors=FALSE)
subject_test <- read.table(".\\CourseProject\\subject_test.txt", stringsAsFactors=FALSE)

activityLabels <- read.table(".\\CourseProject\\activity_labels.txt", stringsAsFactors=FALSE)
rawFeaturesText <- read.table(".\\CourseProject\\features.txt", stringsAsFactors=FALSE)

## append the respective table to the bottom of its compliment table
trainTestCombo <- rbind(testData, testTrain)
labels <- rbind(y_test, y_train)
subjects <- rbind(subject_test, subject_train)


## remove string characters that may cause future problems. 
cleanRaw1 <- gsub("()", "", rawFeaturesText[,2], fixed="TRUE")
cleanRaw2 <- gsub(",", "_", cleanRaw1, fixed="TRUE")
cleanRaw3 <- gsub("-", "_", cleanRaw2, fixed="TRUE")
cleanRaw4 <- gsub("(", "_", cleanRaw3, fixed="TRUE")
cleanRaw5 <- gsub(")", "", cleanRaw4, fixed="TRUE")

## extract mean and std
## split out the mean
##cleanRaw5splitMean <- strsplit((cleanRaw5), "mean", fixed=TRUE) ## results in a list.

cleanRaw6 <- cbind(rawFeaturesText, cleanRaw5) ## this works.  

featuresText <- data.frame(cleanRaw6$V1, cleanRaw6$cleanRaw5)

## add column names to data frame
colnames(trainTestCombo) <- featuresText[, 2]

## associate subjects with their data
trainTestCombo <- cbind(subjects, trainTestCombo)

## rename the added column
trainTestCombo <- rename(trainTestCombo,c("V1" = "subject"))


