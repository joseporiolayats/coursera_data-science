## run_analysis.R script
## This script is made as the course project for
## the Coursera's Getting and Clearing Data
## This script will download, read, merge and tidy 
## the data provided by the course syllabus.

## load libraries
library(tidyverse)

###################
## STEP 0
## Getting the data
####################

## URL where the data is.
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Name to be given to the file
filename <- "w4data.zip"

# Set base directory
wd_old<-getwd()

# Check if data and dirs are ok, else download and extract
ifelse(
        file.exists( filename ),
        print("Files OK"),
        download.file( url, destfile = filename)
)

ifelse(
        dir.exists("UCI HAR Dataset"),
        print("Directories OK"),
        unzip(filename, exdir = wd_old)
)

# Enter the new directory
setwd("UCI HAR Dataset")


###################
## STEP 1
## Merge train and test set
####################

# Read train and subject data
X_train <- read_table("train/X_train.txt", col_names = FALSE) 
subject_train <- read_table("train/subject_train.txt", col_names = "subject")

# Read test and subject data
X_test <- read_table("test/X_test.txt",  col_names = FALSE )
subject_test <- read_table("test/subject_test.txt", col_names = "subject")

# Merge train data
train <- subject_train %>% 
        bind_cols(X_train)
        
# Merge test data
test <- subject_test %>% 
        bind_cols(X_test)

# Merge train and test
mydata1 <- bind_rows(train,test)


###################
## STEP 2
## Extract the measurements of mean and sd
####################

# Read the features table
features_table <- read_table2("features.txt", col_names = FALSE)

# Extract only the labels and add the subject first
features_labels <- c("subject",unlist(features_table[,"X2"]))

# Extract the positions of the desired columns
features_extract <- str_which(features_labels,"subject|mean|std")

# Apply the labels to the dataset
mydata2 <- mydata1[,features_extract]
colnames(mydata2) <- features_labels[features_extract]


###################
## STEP 3
## Use descriptive activity names
####################

# Read all activity data
y_train <- read_table("train/y_train.txt", col_names = FALSE)
y_test <- read_table("test/y_test.txt", col_names = FALSE)

# Merge activity data
activity_merged <- bind_rows(y_train, y_test)

# Read the labels data
activity_labels <- read_table2("activity_labels.txt", col_names = FALSE)

# Assign the names of each acitivty
activity <- activity_merged %>%
        full_join( activity_labels, by= "X1") %>%
        rename( activity = X2, activity_number = X1 )

# Merge with main dataset
mydata3 <- bind_cols( activity, mydata2 )


###################
## STEP 4
## Use clear feature names
####################

# Extract the features
features <- colnames(mydata3)

# Replace cryptic labels with clear names
features_clear <- features %>%
        str_replace_all( "^t", "Time signal ") %>%
        str_replace_all( "^f", "Freq signal ") %>%
        str_replace_all( "BodyAcc", "of the body acceleration ") %>%
        str_replace_all( "BodyGyro", "of the body gyroscope ") %>%
        str_replace_all( "GravityAcc", "gravity accelation ") %>%
        str_replace_all( "Mag", "Euclidean magnitude ") %>%
        str_replace_all( "Jerk", "Jerk ") %>%
        str_replace_all( "Body", "") %>%
        str_replace_all( "X", "X axis") %>%
        str_replace_all( "Y", "Y axis") %>%
        str_replace_all( "Z", "Z axis") %>%
        str_replace_all( "-", "") %>%
        str_replace_all( "mean\\(\\)", "-average- ") %>%
        str_replace_all( "std\\(\\)", "-standard deviation- ") %>%
        str_replace_all( "meanFreq\\(\\)", "-average frequency- ") %>%
        str_replace_all( "(?<=\\()t", "Time signal ") %>%
        str_replace_all( "^angle\\(", "Angle between the ") %>%
        str_replace_all( "\\,", " and the ") %>%
        str_replace_all( "gravity", "gravity ") %>%
        str_replace_all( "Mean", "mean ") %>%
        str_replace_all( "\\)", "")

# Replace column names
mydata4 <- mydata3
names(mydata4) <- features_clear


###################
## STEP 5
## New dataset with the average for each subject and activity
####################

# Datset with average of each variable for each activity and each subject
mydata5 <- mydata4 %>%
        group_by(activity, subject) %>%
        summarise_all(mean) %>%
        arrange(activity_number,activity, subject)

# Return to previous directory
setwd(wd_old)


###################
## FINAL DATASETS
## Identification of each submission dataset
####################

# Full dataset tidied
final_dataset <- mydata5

# Write the dataset file
write.table(final_dataset, file = "final_dataset.txt", row.names = FALSE)

# Script authored by Josep Oriol Ayats.