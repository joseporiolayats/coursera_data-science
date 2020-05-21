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
## QUESTION 5
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
####################

# Prepare the data
mydf5<- NEI %>% 
        filter(fips=="24510") %>%
        left_join(SCC,by="SCC") %>%
        select(year,Emissions,SCC.Level.Two) %>%
        filter_at(vars(SCC.Level.Two),any_vars(str_detect(.,"Vehicle|vehicle"))) %>%
        group_by(year) %>%
        summarize(Emissions = sum(Emissions))


# Plot the data
png("plot5.png", width = 480, height = 480)

ggplot(mydf5,aes(x=factor(year),y=Emissions,fill=year)) + 
        geom_bar(stat="identity",show.legend = FALSE) +
        labs(x="Year",y="PM2.5 Emissions (Tons)",title="Variation of PM2.5 emissions in Baltimore City from Motor Vehicles" )

dev.off()



# Script authored by Josep Oriol Ayats