library(dplyr)
library(naniar)
library(chron)

hhpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";", dec=".", stringsAsFactors=FALSE)

# Add variable 'DateTime' to combine data and time columns 
hhpc$DateTime <- as.POSIXct(paste(hhpc$Date, hhpc$Time), format="%d/%m/%Y %H:%M:%S")

# Convert Date and Time variables to Date and times formats
hhpc1 <- hhpc %>% mutate(Date=as.Date(Date, "%d/%m/%Y"), Time=chron(times=Time))

# Convert the remaining variables to numeric
hhpc1[3:7] <- sapply(hhpc1[3:7],as.numeric)
sapply(hhpc1, class)

# Subset of the data
sub <- subset(hhpc1, Date=="2007-02-01" | Date=="2007-02-02")

# First plot
png("plot1.png")
hist(sub$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main = "Global Active Power")
dev.off()

# Second plot
png("plot2.png")
plot(sub$DateTime, sub$Global_active_power, type="n", xlab="", ylab= "Global Active Power (kilowatts)")
lines(sub$DateTime, sub$Global_active_power)
dev.off()

# Third plot
png("plot3.png")
plot(sub$DateTime, sub$Sub_metering_1, type='n', xlab="", ylab="Energy sub metering")
lines(sub$DateTime, sub$Sub_metering_1)
lines(sub$DateTime, sub$Sub_metering_2, col="red")
lines(sub$DateTime, sub$Sub_metering_3, col="blue")
legend("topright", lty=1, legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"))
dev.off()

# Fourth plot with four plots
png("plot4.png")
par(mfcol=c(2,2))
with(sub, {
    plot(DateTime, Global_active_power, type="n", xlab="", ylab= "Global Active Power (kilowatts)")
    lines(DateTime, Global_active_power)
    
    plot(DateTime, Sub_metering_1, type='n', xlab="", ylab="Energy sub metering")
    lines(DateTime, Sub_metering_1)
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    legend("topright", lty=1, legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"))

    plot(DateTime, Voltage, xlab="datetime", ylab="Voltage", type='n')
    lines(DateTime, Voltage)
    
    plot(DateTime, Global_reactive_power, xlab="datetime", ylab="Global reactive power", type='n')
    lines(DateTime, Global_reactive_power)
    })
dev.off()