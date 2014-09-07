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

options(scipen=999)
hist(powersubset$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.copy(png, file = "plot1.png" ,width = 480, height = 480) 