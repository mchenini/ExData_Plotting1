#Load the needed libraries
library(dplyr)
library(data.table)

setwd("C:\\Users\\u1c332\\Documents\\Coursera\\exploratory-data-analysis\\Week1\\Project1")

#Reads data from input file and then subsets data for the specified dates

inData <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", stringsAsFactors=F, comment.char="", quote='\"')
powerCons <- subset(inData, Date %in% c("1/2/2007","2/2/2007"))

#Convert global active power column, global reactive power colums, Sub_metering columns, and the Voltage column to numeric

powerCons$Global_active_power <- as.numeric(as.character(powerCons$Global_active_power))
powerCons$Global_reactive_power <- as.numeric(as.character(powerCons$Global_reactive_power))
powerCons$Sub_metering_1 <- as.numeric(as.character(powerCons$Sub_metering_1))
powerCons$Sub_metering_2 <- as.numeric(as.character(powerCons$Sub_metering_2))
powerCons$Sub_metering_3 <- as.numeric(as.character(powerCons$Sub_metering_3))
powerCons$Voltage <- as.numeric(as.character(powerCons$Voltage))

#Creates new column that combines date and time data 
#powerCons$Timestamp <-paste(powerCons$Date, powerCons$Time)
TimeStamp <- strptime(paste(powerCons$Date, powerCons$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
powerCons <- cbind(powerCons, TimeStamp)

##Create a graph  for Global Active Power
## histogram for Global Active Power
png("plot3.png", width=480, height=480)

## Creates graph of date/time vs global active power data

with(powerCons, plot(TimeStamp, Sub_metering_1, type="l", xlab="Day", ylab="Energy sub metering"))
lines(powerCons$TimeStamp, powerCons$Sub_metering_2,type="l", col= "red")
lines(powerCons$TimeStamp, powerCons$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))

dev.copy(png, file = "plot3.png")
##  close the PNG device!
dev.off()