library(data.table)
library(dplyr)

data <- tbl_df(fread("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE, na.strings=c("?"), colClasses = c(rep("character", 9))))
data <- 
  data %>%
  mutate(
    Global_active_power = as.numeric(Global_active_power),
    Voltage = as.numeric(Voltage),
    Sub_metering_1 = as.numeric(Sub_metering_1),
    Sub_metering_2 = as.numeric(Sub_metering_2),
    Sub_metering_3 = as.numeric(Sub_metering_3),
    Global_reactive_power = as.numeric(Global_reactive_power),
    DateTime = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))
  ) %>%
  filter(strftime(DateTime, format="%Y-%m-%d") == "2007-02-01" | strftime(DateTime, format="%Y-%m-%d") == "2007-02-02")

png("Plot4.png", width=480, height=480, bg="white")
par(mfrow=c(2,2))

#Top Left Plot
plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

#Top Right Plot
plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

#Bottom Left Plot
plot(data$DateTime, data$Sub_metering_1, type="n", xlab="", ylab="Energy Sub Metering")
lines(data$DateTime, data$Sub_metering_1, col="black")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1),col=c("black","red", "blue"), cex=0.7, bty="n")

#Bottom Right Plot
plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()