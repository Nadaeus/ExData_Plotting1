# read txt file
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

## plot1
png(filename = 'plot1.png', width = 480, height = 480)
hist(rDF$Global_active_power,  col = "Red", border = "Black", freq = T, 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
