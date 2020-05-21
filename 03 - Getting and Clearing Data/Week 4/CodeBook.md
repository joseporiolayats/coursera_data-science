# CodeBook.md
### Getting and Cleaning Data, Week 4 Assignment for peer review

# Codebook for run_script.r

This is the code book that describes the variables, the data, and any transformations or work that is performed to clean up the data.

## Step 0
### Getting the data
The script first loads the required packages, tidyverse.
Then the url is assigned to download the file, which is named.
A script checks if the file is present and if it's been extracted, if not, it downloads and extracts the data.
Once checked and/or extracted, the working directory is set inside the folder "UCI HAR Dataset".

## Step 1
### Merge the training and the test sets to create one data set.
The script here reads the files as tibbles, and it stores its values in a variable with the same name of the file.
Reading X and subject data:

- X_train = train/X_train.txt
- subject_train = train/subject_train.txt
- X_test = test/X_test.txt
- subject_test = test/subject_test.txt

Then it merges the train and test X data in "train" and "test" varibles. Afterwards, it joins both datasets into one: 
**mydata1** , which is the result of the first step.

## Step 2
### Extract only the measurements on the mean and standard deviation for each measurement.
First it loads the features.txt into features_table, but as it is a tibble, it needs to be unlisted to be extracted as characters.
So this is what is done in features_labels. Also here it is inserted the first value which is "subject", which is the name of the first column and is not included into the features.txt previously parsed.
Then we have to do the selection of the labels which include mean and std , as requested in this step. They are stored into features_extract.
After we have the locations of the desired labels, we subset them to the main dataset, and afterwards we subset the same locations into the labels themselves, to apply them into the main dataframe, **mydata2**, which is the result of the second step.

## Step 3
### Uses descriptive activity names to name the activities in the data set
First we read the activity data in its text files and merge it.

- y_train = train/y_train.txt
- y_test = test/y_test.txt
- y_merged = merged train and test
- activity_labels = activity_labels.txt

Then we match and join the activity data (y_merged) with their reference labels (activity_labels), we store it into activity and append it as a new column into the main dataframe. The resulting dataframe is **mydata3**, which is the result of the third step.

## Step 4
### Appropriately label the data set with descriptive variable names.
The names of the variables are very cryptic, so here we're gonna replace some strips to make it more readable.
First we save the actual names into the features vector and then we start replacing, based on the info found in feature_info.txt
By using regex we are able to strip apart each part and replace with meaningful info. Each step  is piped into the next, and the resulting names are stored into features_clear.
So we create a copy of the main dataframe and then we assign its new column names with very descriptive names. It is stored as **mydata4**, which is the result  of the third step.

## Step 5
### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
In this step we will pipe the main dataframe mydata4 and apply various tidy data verbs.
We first do a group_by to activity and subject in order to create the desired groups. Then we summarise_all passing the mean function to create, for each group, the average of the variable. Finally we arrange them to make it more readable. The resulting dataframe is **mydata5**, which is the result of the fifth step.

## FINAL DATASETS
### Identification of each submission dataset

- **final_dataset** <- mydata5

Script authored by Josep Oriol Ayats.