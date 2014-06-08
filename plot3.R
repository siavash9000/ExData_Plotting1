tryCatch({
  data<-read.csv("household_power_consumption.txt",na.strings='?',sep=";")
},warning = function(w) {
  print("The data file is missing. Please download and extract the file household_power_consumption.txt from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
}, error = function(e) {
  print("The data file is missing. Please download and extract the file household_power_consumption.txt from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
})
data$Time <- paste(data$Date, data$Time)
data$Time <- strptime(data$Time,"%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date,"%d/%m/%Y")
february_begin<-subset(data,data$Date>=as.Date("2007-02-01")&data$Date<=as.Date("2007-02-02"))
png(file = "plot3.png")
plot(x=february_begin$Time,y=february_begin$Sub_metering_1, ylab="Energy sub metering",type='l',xlab="")
with(february_begin, lines(Time, Sub_metering_2,col="red"))
with(february_begin, lines(Time, Sub_metering_3,col="blue"))
legend("topright", lty=c(1,1), col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),pt.cex=1,cex=1) 
dev.off()