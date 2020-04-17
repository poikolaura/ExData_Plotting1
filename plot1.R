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
