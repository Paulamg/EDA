#This code runs the function to create the second plot of the assignment

unzip("exdata-data-household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE)
library(dplyr)
data <- tbl_df(data)
data$Date=as.Date.factor(data$Date, "%d/%m/%Y")
dates <- filter(data, Date == "2007-02-01"| Date=="2007-02-02")
dates <- mutate(dates, completedate = paste(Date, Time), 
        Sub_metering_1=as.numeric(dates$Sub_metering_1), 
      Sub_metering_2 =as.numeric(dates$Sub_metering_2))
dates$cd = strptime(dates$completedate, "%Y-%m-%d %H:%M:%S")
dates$cd <- as.POSIXct(dates$cd)
dev.new(width=480, height=480)
with(dates, plot(cd, Sub_metering_1, type="n", 
                 ylab="Energy sub metering", xlab="", cex=0.8)) 
legend("topright", pch= "-", col=c("black", "red", "blue"), 
     legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") , cex=1)
lines(dates$cd, dates$Sub_metering_1, col="black", type="l")
lines(dates$cd, dates$Sub_metering_2, col="red", type="l")
lines(dates$cd, dates$Sub_metering_3, col="blue", type="l")
dev.copy(png, "plot3.png")
dev.off()
 

