# read txt file
if(!exists("rDF")) {
  powerDF <- read.table("./household_power_consumption.txt", sep = ";", header = T, 
                        stringsAsFactors = F)
  concatDate <- paste(powerDF$Date, powerDF$Time, sep = " " )
  DateC <- strptime(concatDate, format = "%d/%m/%Y %H:%M:%S")
  powerDF$Date <- DateC
  concatDate <- NULL
  DateC <- NULL
  rDF <- powerDF[which((as.Date(powerDF$Date, "%Y-%m-%d") >= "2007-02-01") &  
                         (as.Date(powerDF$Date, "%Y-%m-%d") <= "2007-02-02")), ]
  rDF$Global_active_power <- as.numeric(rDF$Global_active_power)
  rownames(rDF) <- NULL
}

## plot4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), cex=.6)
with(rDF, plot(Date, Global_active_power, type ="l" , 
               ylab = "Global Active Power" ))
plot(rDF$Date, rDF$Voltage, type = "l", ylab = "Voltage", xlab="Datetime")


with(rDF, {
  plot(Date, Sub_metering_1, type = "l", col = "Black", ylab = "Energy sub metering")
  lines(Date, Sub_metering_2, type = "l", col = "Red")
  lines(Date, Sub_metering_3, type = "l", col = "Blue")
  legend( border = "White" ,  "topright", legend = c("Sub_metering_1", "Sub_metering_2", 
                                "Sub_metering_3"),  
             lty = 1 , col = c("black", "red", "blue"))
})

with(rDF, plot(Date, Global_reactive_power, type = "l", ylab = "Global reactive power"))

dev.off()

