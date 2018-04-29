# plot1.R

#Load libraries
library("dplyr")

#Read and load data
data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)

#convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
#transmute(data, Date = as.Date(Date))

#filter dates between 2007-02-01 and 2007-02-02
date <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

#Open the device and set the correct size
png("plot1.png", width = 480, height = 480)

#Plot1
hist(date$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     ylab = "Frequency", 
     xlab = "Global Active Power (kilowatts)")

#Close device
dev.off()

