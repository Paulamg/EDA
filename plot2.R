#This code runs the function to create the second plot of the assignment

unzip("exdata-data-household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
library(dplyr)
data <- tbl_df(data)
data$Date=as.Date.factor(data$Date, "%d/%m/%Y")
dates <- filter(data, Date == "2007-02-01"| Date=="2007-02-02")
dates <- mutate(dates, Global_active_power = as.numeric(as.character(dates$Global_active_power)), 
                completedate = paste(Date, Time))
dates$cd = strptime(dates$completedate, "%Y-%m-%d %H:%M:%S")
dates$cd <- as.POSIXct(dates$cd)
dev.new(width=480, height=480)
with(dates, plot(cd, Global_active_power, pch="", ylab="Global Active Power (kilowattz)", xlab=""))
lines(dates$cd, dates$Global_active_power)
dev.copy(png, "plot2.png")
dev.off()

