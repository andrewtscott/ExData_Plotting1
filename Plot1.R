library(data.table)
library(dplyr)

data <- tbl_df(fread("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE, na.strings=c("?"), colClasses = c(rep("character", 9))))
data <- 
  data %>%
    mutate(
      Global_active_power = as.numeric(Global_active_power),
      DateTime = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))
    ) %>%
    filter(strftime(DateTime, format="%Y-%m-%d") == "2007-02-01" | strftime(DateTime, format="%Y-%m-%d") == "2007-02-02") %>%
    select(DateTime, Global_active_power)

png("Plot1.png", width=480, height=480, bg="white")
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col="Red")
dev.off()