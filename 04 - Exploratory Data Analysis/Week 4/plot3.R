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
## QUESTION 3
## Of the four types of sources indicated by the (point, nonpoint, onroad, nonroad) variable, which have seen decreases in emissions from 1999–2008 for Baltimore City?
## Which have seen increases in emissions from 1999–2008? 
####################

# Prepare the data

mydf3 <- NEI %>% 
        group_by(year,type) %>%
        filter(fips=="24510") %>%
        summarize(Emissions = sum(Emissions))


# Plot the data
png("plot3.png", width = 480, height = 480)

ggplot(mydf3,aes(x=factor(year),y=Emissions,fill=type)) + 
        geom_bar(stat="identity",show.legend = FALSE) +
        facet_wrap(~type) +
        labs(x="Year",y="PM2.5 Emissions (Tons)",title="Variation of PM2.5 emissions in Baltimore City by source type" )

dev.off()



# Script authored by Josep Oriol Ayats