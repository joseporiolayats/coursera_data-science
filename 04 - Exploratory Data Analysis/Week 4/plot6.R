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
## QUESTION 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California.
## Which city has seen greater changes over time in motor vehicle emissions?
####################

# Prepare the data
mydf6<- NEI %>% 
        filter(fips %in% c("24510","06037")) %>%
        left_join(SCC,by="SCC") %>%
        select(fips,year,Emissions,SCC.Level.Two) %>%
        filter_at(vars(SCC.Level.Two),any_vars(str_detect(.,"Vehicle|vehicle"))) %>%
        group_by(fips,year) %>%
        summarize(Emissions = sum(Emissions)) %>%
        mutate(Location = ifelse(fips == "06037","Los Angeles County","Baltimore City"))

# Plot the data
png("plot6.png", width = 480, height = 480)

ggplot(mydf6,aes(x=factor(year),y=Emissions,fill=Location)) + 
        geom_bar(stat="identity",show.legend = FALSE) +
        labs(x="Year",y="PM2.5 Emissions (Tons)",title="Variation of PM2.5 emissions in Baltimore City and LA County from Vehicles" ) +
        facet_wrap(~ Location,scales="free")

dev.off()


# Script authored by Josep Oriol Ayats