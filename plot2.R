# plot2.R

#Load libraries
library("dplyr")

#Read and load data
data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)

#convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
mut_data <- mutate(data, Date = as.Date(Date, "%d/%m/%Y"))

#filter dates between 2007-02-01 and 2007-02-02
filter_data <- (filter(mut_data, Date == "2007-2-1" | Date == "2007-2-2"))


#merge date and time
time <- transmute(filter_data, dateTime = paste(Date,Time, sep = " "))
nTime <- as.POSIXct(time$dateTime, format = "%Y-%m-%d %H:%M:%S")
ready <- cbind(nTime, filter_data)
                

#Open the device and set the correct size
png("plot2.png", width = 480, height = 480)

#Plot2
plot(ready$Global_active_power ~ ready$nTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab =" ")


#Close device
dev.off()

