###################################################################################################
## This is the script for the course from
## Coursera
## Getting and Cleaning Data
## Week 2
## Quiz
## Exercise 4
##
## QUESTION
##How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
##http://biostat.jhsph.edu/~jleek/contact.html
##(Hint: the nchar() function in R may be helpful)
###################################################################################################



# 0. Libraries

require(readr)


# 1. Data we want

url <- "http://biostat.jhsph.edu/~jleek/contact.html"
reqlines <- c(10,20,30,100)


# 2. Download file and store it in a variable

webpage <- read_lines(url)

# 3. Do the counting

values <- sapply(webpage[reqlines],nchar,USE.NAMES = FALSE)
values
