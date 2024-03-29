setwd("~/explorpa1/")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"power.zip",method="curl",cacheOK=TRUE)
unzip("power.zip",  overwrite = TRUE,
      exdir = "./data", unzip = "internal",
      setTimes = FALSE)
power <- read.csv("./data/household_power_consumption.txt",sep=";",na.strings="?")
power$Date2 <- as.Date(power$Date,"%d/%m/%Y")
powersubset <- power[which(power$Date2 >= "2007-02-01" & power$Date2 <= "2007-02-02"),]
powersubset$Time2 <- strptime(powersubset$Time,format="%H:%M:%S")
powersubset$datetime <-  paste(powersubset$Date, powersubset$Time)
powersubset$datetime <-  strptime(powersubset$datetime, "%d/%m/%Y %H:%M:%S") 

par(bg="white")
par(mfcol=c(2,2))
with(powersubset,plot(datetime,Global_active_power,type="l",col="black",ylab="Global Active Power (kilowatts)"))
with(powersubset,plot(datetime,Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering"))
with(powersubset,lines(datetime,Sub_metering_2,type="l",col="red"))
with(powersubset,lines(datetime,Sub_metering_3,type="l",col="blue"))
legend("topright", lty=1, lwd=2, box.lwd=0,
       col = c("black","red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(powersubset,plot(datetime,Voltage,type="l",col="black"))
with(powersubset,plot(datetime,Global_reactive_power,type="l",col="black"))
dev.copy(png, file = "plot4.png" ,width = 480, height = 480) 