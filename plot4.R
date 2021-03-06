# > grep -nr "1/2/2007" household_power_consumption.txt | head -n1
# household_power_consumption.txt:66638:1/2/2007;00:00:00;0.326;0.128;243.150;1.400;0.000;0.000;0.000
# > grep -nr "3/2/2007" household_power_consumption.txt | head -n1
# household_power_consumption.txt:69518:3/2/2007;00:00:00;3.614;0.106;240.990;15.000;0.000;1.000;18.000

#setwd("/Users/michaeldavidson/Documents/Coursera/DataScience/4/proj1")

library(lubridate)

# Load the required lines from the data file and reestablish column names.
headers <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
d <- read.csv("household_power_consumption.txt",sep=";",na.strings = "?",stringsAsFactors = FALSE, skip=66637,nrows=2879);
colnames (d) <- headers

# Make the columns we care about be of the right type.
d$Date <- paste(d$Date,d$Time)
d$Date <- dmy_hms(d$Date)
d$Global_reactive_power <- as.numeric(d$Global_reactive_power);
d$Global_reactive_power <- as.numeric(d$Global_reactive_power);
d$Sub_metering_1 <- as.numeric(d$Sub_metering_1);
d$Sub_metering_2 <- as.numeric(d$Sub_metering_2);
d$Sub_metering_3 <- as.numeric(d$Sub_metering_3);
d$Voltage <- as.numeric(d$Voltage);

# Plot to file.
png("plot4.png",width=480,height=400)

# Set up the multiplot.
par(mfrow=(c(2,2)))
par(cex=.6)

# Plot row 1, col 1
plot(d$Date,d$Global_active_power,type="l",xlab="",ylab="Global Active Power")

# Plot row 1, col 2
plot(d$Date,d$Voltage,xlab="datetime",ylab="Voltage",type="l")

# Plot row 2, col 1
plot(d$Date,d$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(d$Date,d$Sub_metering_2,col="red",type="l")
lines(d$Date,d$Sub_metering_3,col="blue",type="l")
legend("topright",box.lwd=0,lty=1,lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Plot row 2, col 2
plot(d$Date,d$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()