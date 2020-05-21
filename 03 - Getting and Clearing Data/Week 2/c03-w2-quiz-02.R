###################################################################################################
## This is the script for the course from
## Coursera
## Getting and Cleaning Data
## Week 2
## Quiz
## Exercise 2
##
## QUESTION
## The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf
## package to practice the queries we might send with the dbSendQuery command in RMySQL.
## Download the American Community Survey data and load it into an R object called acs
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
## Which of the following commands will select only the data for the probability weights pwgtp1
## with ages less than 50?
###################################################################################################



# 0. Libraries

require(RMySQL)
require(sqldf)


# 1. Data we want

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"


# 2. Download file and store it in a variable

acs <- read.csv(url)


# 3. 
sqldf("select pwgtp1 from acs where AGEP < 50")