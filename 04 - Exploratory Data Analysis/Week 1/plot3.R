<<<<<<< HEAD
# Script for reading the data, creating the plot and exporting it

#########################
## PLOT 3
#########################


## load libraries
library(tidyverse)

###################
## STEP 0
## Getting the data
####################

## URL where the data is.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Name to be given to the zip file and the data file
zipname <- "w1data.zip"
textfile <- "household_power_consumption.txt"

# Check if data and dirs are ok, else download and extract
ifelse(
        file.exists( zipname ),
        print("Files OK"),
        download.file( url, destfile = filename)
)

ifelse(
        file.exists( textfile ),
        print("Data OK"),
        unzip(filename, exdir = getwd())
)


###################
## STEP 1
## Reading and cleaning the data
####################

# Make a file connection to speed up the reading process
connection <- file(textfile,open="r")
lines_read <- readLines(connection)

# Initialize an empty vector and populate it with the desired dates.
# Break the loop once it surpasses the date.
mydata1 <- as.vector(NULL)

for (i in 1:length(lines_read)) {
        
        ifelse(str_detect(lines_read[i],"^1/2/2007|^2/2/2007"),
               mydata1 <- c(mydata1,lines_read[i]),
               0)
        
        ifelse(str_detect(lines_read[i],"^3/2/2007"),
               break, 0)
}
close(connection)
rm(lines_read,i)

# Extract the names of the columns from the first line of the source data
mynames <- names(read_delim(textfile,na="?",delim=";",n_max=1))

# Read the saved data, remove NAs and change the class of the first column to date.
mydata2 <- mydata1 %>%
        read_delim(delim=";",na="?",col_names = mynames) %>%
        na.omit() %>%
        mutate( Date = as.Date( strptime(Date,"%d/%m/%Y" )))

mydata <- mydata2 %>%
        mutate(dateTime = as.POSIXct(paste(mydata2$Date,mydata2$Time),format="%Y-%m-%d %H:%M"))

rm(mydata1,mydata2)

###################
## STEP 2 
## Creating and exporting plot
####################

# Create the device with the name
png("plot3.png", width = 480, height = 480)

# Create the plot with specified axis labels
plot(x=mydata$dateTime,y=mydata$Sub_metering_1,type="l",xaxt='n',ann=FALSE)
lines(x=mydata$dateTime,y=mydata$Sub_metering_2,col = "red")
lines(x=mydata$dateTime,y=mydata$Sub_metering_3,col = "blue")
axis(1,at=c(min(mydata$dateTime),median(mydata$dateTime),max(mydata$dateTime)),labels=c("Thu","Fri","Sat"))
title(ylab="Energy sub metering")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)

# Close the device and save the exported file
dev.off()

# Script authored by Josep Oriol Ayats.
=======
# Script for reading the data, creating the plot and exporting it

#########################
## PLOT 3
#########################


## load libraries
library(tidyverse)

###################
## STEP 0
## Getting the data
####################

## URL where the data is.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Name to be given to the zip file and the data file
zipname <- "w1data.zip"
textfile <- "household_power_consumption.txt"

# Check if data and dirs are ok, else download and extract
ifelse(
        file.exists( zipname ),
        print("Files OK"),
        download.file( url, destfile = filename)
)

ifelse(
        file.exists( textfile ),
        print("Data OK"),
        unzip(filename, exdir = getwd())
)


###################
## STEP 1
## Reading and cleaning the data
####################

# Make a file connection to speed up the reading process
connection <- file(textfile,open="r")
lines_read <- readLines(connection)

# Initialize an empty vector and populate it with the desired dates.
# Break the loop once it surpasses the date.
mydata1 <- as.vector(NULL)

for (i in 1:length(lines_read)) {
        
        ifelse(str_detect(lines_read[i],"^1/2/2007|^2/2/2007"),
               mydata1 <- c(mydata1,lines_read[i]),
               0)
        
        ifelse(str_detect(lines_read[i],"^3/2/2007"),
               break, 0)
}
close(connection)
rm(lines_read,i)

# Extract the names of the columns from the first line of the source data
mynames <- names(read_delim(textfile,na="?",delim=";",n_max=1))

# Read the saved data, remove NAs and change the class of the first column to date.
mydata2 <- mydata1 %>%
        read_delim(delim=";",na="?",col_names = mynames) %>%
        na.omit() %>%
        mutate( Date = as.Date( strptime(Date,"%d/%m/%Y" )))

mydata <- mydata2 %>%
        mutate(dateTime = as.POSIXct(paste(mydata2$Date,mydata2$Time),format="%Y-%m-%d %H:%M"))

rm(mydata1,mydata2)

###################
## STEP 2 
## Creating and exporting plot
####################

# Create the device with the name
png("plot3.png", width = 480, height = 480)

# Create the plot with specified axis labels
plot(x=mydata$dateTime,y=mydata$Sub_metering_1,type="l",xaxt='n',ann=FALSE)
lines(x=mydata$dateTime,y=mydata$Sub_metering_2,col = "red")
lines(x=mydata$dateTime,y=mydata$Sub_metering_3,col = "blue")
axis(1,at=c(min(mydata$dateTime),median(mydata$dateTime),max(mydata$dateTime)),labels=c("Thu","Fri","Sat"))
title(ylab="Energy sub metering")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)

# Close the device and save the exported file
dev.off()

# Script authored by Josep Oriol Ayats.
=======
# Script for reading the data, creating the plot and exporting it

#########################
## PLOT 3
#########################


## load libraries
library(tidyverse)

###################
## STEP 0
## Getting the data
####################

## URL where the data is.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Name to be given to the zip file and the data file
zipname <- "w1data.zip"
textfile <- "household_power_consumption.txt"

# Check if data and dirs are ok, else download and extract
ifelse(
        file.exists( zipname ),
        print("Files OK"),
        download.file( url, destfile = filename)
)

ifelse(
        file.exists( textfile ),
        print("Data OK"),
        unzip(filename, exdir = getwd())
)


###################
## STEP 1
## Reading and cleaning the data
####################

# Make a file connection to speed up the reading process
connection <- file(textfile,open="r")
lines_read <- readLines(connection)

# Initialize an empty vector and populate it with the desired dates.
# Break the loop once it surpasses the date.
mydata1 <- as.vector(NULL)

for (i in 1:length(lines_read)) {
        
        ifelse(str_detect(lines_read[i],"^1/2/2007|^2/2/2007"),
               mydata1 <- c(mydata1,lines_read[i]),
               0)
        
        ifelse(str_detect(lines_read[i],"^3/2/2007"),
               break, 0)
}
close(connection)
rm(lines_read,i)

# Extract the names of the columns from the first line of the source data
mynames <- names(read_delim(textfile,na="?",delim=";",n_max=1))

# Read the saved data, remove NAs and change the class of the first column to date.
mydata2 <- mydata1 %>%
        read_delim(delim=";",na="?",col_names = mynames) %>%
        na.omit() %>%
        mutate( Date = as.Date( strptime(Date,"%d/%m/%Y" )))

mydata <- mydata2 %>%
        mutate(dateTime = as.POSIXct(paste(mydata2$Date,mydata2$Time),format="%Y-%m-%d %H:%M"))

rm(mydata1,mydata2)

###################
## STEP 2 
## Creating and exporting plot
####################

# Create the device with the name
png("plot3.png", width = 480, height = 480)

# Create the plot with specified axis labels
plot(x=mydata$dateTime,y=mydata$Sub_metering_1,type="l",xaxt='n',ann=FALSE)
lines(x=mydata$dateTime,y=mydata$Sub_metering_2,col = "red")
lines(x=mydata$dateTime,y=mydata$Sub_metering_3,col = "blue")
axis(1,at=c(min(mydata$dateTime),median(mydata$dateTime),max(mydata$dateTime)),labels=c("Thu","Fri","Sat"))
title(ylab="Energy sub metering")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)

# Close the device and save the exported file
dev.off()

# Script authored by Josep Oriol Ayats.
>>>>>>> bbdcb4438ef834beec53c3140229664694ac0186
>>>>>>> 9a46e0b... a
