#plot1.R
#Setting Working folder setwd("c:/Data Mining Class/EDA")

#clear workspace
rm(list = ls())
graphics.off()

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "power.zip"

#For window 7, we will need to set  setInternet2(use = TRUE)
setInternet2(use = TRUE)

if(!file.exists(destfile)){
  download.file(URL,destfile = destfile)
}

#unzip and reading complete data -- i have opened the file and saw it is separated by semicolon
unzip ("power.zip")
data <- read.csv("household_power_consumption.txt", sep=";")

#names(data)
#class(data$Date) -- Need to convert this column to Date Type
# Y is in Capital, took sometime to realize
data$Date <- as.Date(data$Date,"%d/%m/%Y")
StartDate <-as.Date("2007-02-01","%Y-%m-%d")
EndDate <- as.Date("2007-02-02","%Y-%m-%d")
#subsetting data for this Plot
dataToUse <- data[data$Date >= StartDate & data$Date <= EndDate ,]
#hist data
grp <- as.numeric(dataToUse$Global_reactive_power)
#creating plot
hist(grp,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
#creating png file
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()