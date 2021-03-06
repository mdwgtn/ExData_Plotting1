# > grep -nr "1/2/2007" household_power_consumption.txt | head -n1
# household_power_consumption.txt:66638:1/2/2007;00:00:00;0.326;0.128;243.150;1.400;0.000;0.000;0.000
# > grep -nr "3/2/2007" household_power_consumption.txt | head -n1
# household_power_consumption.txt:69518:3/2/2007;00:00:00;3.614;0.106;240.990;15.000;0.000;1.000;18.000

#setwd("/Users/michaeldavidson/Documents/Coursera/DataScience/4/proj1")

# Load the required lines from the data file and reestablish column names.
headers <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
d <- read.csv("household_power_consumption.txt",sep=";",na.strings = "?",stringsAsFactors = FALSE, skip=66637,nrows=2879);
colnames (d) <- headers

# Make the columns we care about be of the right type.
d$Global_active_power <- as.numeric(d$Global_active_power);

# Plot to file.
png(filename="plot1.png",width=480,height=400)
hist(d$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency",main="Global Active Power");
dev.off()