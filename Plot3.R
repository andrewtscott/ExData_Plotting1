library(data.table)
library(dplyr)

data <- tbl_df(fread("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE, na.strings=c("?"), colClasses = c(rep("character", 9))))
data <- 
  data %>%
  mutate(
    Sub_metering_1 = as.numeric(Sub_metering_1),
    Sub_metering_2 = as.numeric(Sub_metering_2),
    Sub_metering_3 = as.numeric(Sub_metering_3),
    DateTime = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))
  ) %>%
  filter(strftime(DateTime, format="%Y-%m-%d") == "2007-02-01" | strftime(DateTime, format="%Y-%m-%d") == "2007-02-02") %>%
  select(DateTime, Sub_metering_1, Sub_metering_2, Sub_metering_3)

png("Plot3.png", width=480, height=480, bg="white")
plot(data$DateTime, data$Sub_metering_1, type="n", xlab="", ylab="Energy Sub Metering")
lines(data$DateTime, data$Sub_metering_1, col="black")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1),col=c("black","red", "blue"))
dev.off()