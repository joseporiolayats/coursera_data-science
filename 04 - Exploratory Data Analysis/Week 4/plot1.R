## run_analysis.R script
## This script is made as the course project for
## the Coursera's Exploratory Data Analysis
## This script will download, tidy and plot
## the data provided by the course syllabus.

## load libraries
library(tidyverse)

###################
## STEP 0
## Getting the data
####################

## URL where the data is.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# Name to be given to the zip file and the data file
zipname <- "w4data.zip"

# Check if data and dirs are ok, else download and extract
ifelse(
        file.exists(zipname),
        print("Files OK"),
        {download.file( url, destfile = zipname)
                unzip(zipname, exdir = getwd())
        }
)



###################
## STEP 1
## Reading and cleaning the data
####################

## Read data with read RDS format
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


###################
## QUESTION 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
####################

# Prepare the data
mydf1 <- NEI %>% 
        group_by(year) %>%
        summarize(Emissions = sum(Emissions))

# Plot the data
png("plot1.png", width = 480, height = 480)

with(mydf1,
     barplot(
             Emissions,
             names.arg=year,
             xlab="Year",
             ylab="PM2.5 Emissions (Tons)",
             main="Yearly PM2.5 emissions in the US",
             col=year
     )
)

dev.off()



# Script authored by Josep Oriol Ayats