# plot4.R

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
png("plot4.png", width = 480, height = 480)

#Plot4
par(mfcol=c(2,2))

#Plot 4.1 (top Left)
plot(ready$Global_active_power ~ ready$nTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab =" ")


#plot 4.2 (bottom left)
#plot the variables separetely graph
with(ready, plot(Sub_metering_1~nTime, type ="l", ylab = "Energy sub metering"))
with(ready, points(Sub_metering_2~nTime, type ="l", col = "red"))
with(ready, points(Sub_metering_3~nTime, type ="l", col = "blue"))

#add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue"), lty=1)


#Plot 4.3 (top right)
with(ready, plot(nTime, Voltage, type = "l", xlab = "datetime"))

#plot 4.4 (bottom right)
with(ready, plot(nTime, Global_reactive_power, type = "l", xlab = "datetime"))

#Close device
dev.off()

