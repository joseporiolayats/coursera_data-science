###################################################################################################
## This is the script for the course from
## Coursera
## Getting and Cleaning Data
## Week 2
## Quiz
## Exercise 5
##
## QUESTION
## Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
## https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
## Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
## (Hint this is a fixed width file format)
###################################################################################################



# 0. Libraries

require(readr)
require(tidyr)
require(lubridate)


# 1. Data we want

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
reqline <- 4


# 2. Download file and store it in a variable

webpage <- read_table(url, skip = 4,col_names = FALSE)

# 3. Tidying the dataset (separate columns)

webpage <- separate(webpage,X2,c("X20","X25"), sep = "-| " )
webpage <- separate(webpage,X3,c("X30","X35"), sep = "-| " )
webpage <- separate(webpage,X4,c("X40","X45"), sep = "-| " )
webpage <- separate(webpage,X5,c("X50","X55"), sep = "-| " )

webpage$X1 <- dmy(webpage$X1)

tibble.to.numeric <- function(x){
        for(j in 2:length(x)){
                x[[j]] <- as.numeric(x[[j]])
        }
        return(x)
}

webpage <- tibble.to.numeric(webpage)

values <- sum(webpage[[reqline]])
values
