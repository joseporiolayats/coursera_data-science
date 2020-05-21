# README.md
### Getting and Cleaning Data, Week 4 Assignment for peer review


The task is to collect, work with and clean a data set, tidying it up.
The data is from movement sensors on a wearable device.


The script to run is "run_analysis.R"

It first checks if the datasoruce is available, and if not, downloads it.
Then it performs all the wrangling.

The script is well commented and structured into various steps, as required by the assignment.

The assignment is:
Create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The final dataset: 
- final_dataset

There is only one package loaded, which is tidyverse group of packages.
If not installed, run
install.packages("tidyverse")

Script authored by Josep Oriol Ayats.