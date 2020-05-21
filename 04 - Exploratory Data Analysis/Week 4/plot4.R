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
## QUESTION 4
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
####################

# Prepare the data
mydf4<- NEI %>% 
        left_join(SCC,by="SCC") %>%
        select(year,Emissions,Short.Name) %>%
        filter_at(vars(Short.Name),any_vars(str_detect(.,"coal|Coal"))) %>%
        group_by(year) %>%
        summarize(Emissions = sum(Emissions))


# Plot the data
png("plot4.png", width = 480, height = 480)

ggplot(mydf4,aes(x=factor(year),y=Emissions,fill=year)) + 
        geom_bar(stat="identity",show.legend = FALSE) +
        labs(x="Year",y="PM2.5 Emissions (Tons)",title="Variation of PM2.5 emissions in the US from Coal Combustion" )

dev.off()


# Script authored by Josep Oriol Ayats