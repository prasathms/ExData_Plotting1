#plot4.R
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
data$Date <- as.Date(data$Date,"%d/%m/%Y")
StartDate <-as.Date("2007-02-01","%Y-%m-%d")
EndDate <- as.Date("2007-02-02","%Y-%m-%d")
#subsetting data for this Plot
dataToUse <- data[data$Date >= StartDate & data$Date <= EndDate ,]

#Adding new columns
# Xaxis which combining Date and Time
# GRP changing factor to numberic
dataToUse$Xaxis <- strptime(paste(format(dataToUse$Date,"%d/%m/%Y"), dataToUse$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
dataToUse$Global_active_power <- as.numeric(dataToUse$Global_active_power)
dataToUse$Sub_metering_1 <- as.numeric(dataToUse$Sub_metering_1)
dataToUse$Sub_metering_2 <- as.numeric(dataToUse$Sub_metering_2)
dataToUse$Sub_metering_3 <- as.numeric(dataToUse$Sub_metering_3)
dataToUse$Voltage <- as.numeric(dataToUse$Voltage)
dataToUse$Global_reactive_power <- as.numeric(dataToUse$Global_reactive_power)
#names(dataToUse) 
#Checked added new columns
#http://www.statmethods.net/graphs/line.html
par(mfcol=c(2,2))

#creating plot column=1 & row=1
with(dataToUse,plot(Xaxis, Global_active_power, type="l", xlab="", ylab="Global Active Power"))

#creating plot column=1 & row=2
with(dataToUse,plot(Xaxis, Sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering"))
with(dataToUse,lines(Xaxis,Sub_metering_2,col="red"))
with(dataToUse,lines(Xaxis,Sub_metering_3,col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=par("lwd"),cex = 0.5)

#creating plot column=2 & row=1
with(dataToUse,plot(Xaxis, Voltage, type="l", xlab="datetime", ylab="Voltage"))

#creating plot column=2 & row=2
with(dataToUse,plot(Xaxis, Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power"))

#creating png file
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()