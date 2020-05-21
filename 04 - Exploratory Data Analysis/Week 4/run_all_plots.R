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


###################
## QUESTION 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?
####################

# Prepare the data
mydf2 <- NEI %>% 
        filter(fips=="24510") %>%
        group_by(year) %>%
        summarize(Emissions = sum(Emissions))

# Plot the data
png("plot2.png", width = 480, height = 480)

with(mydf2,
     barplot(
             Emissions,
             names.arg=year,
             xlab="Year",
             ylab="PM2.5 Emissions (Tons)",
             main="Variation of PM2.5 emissions in Baltimore City",
             col=year
     )
)

dev.off()


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