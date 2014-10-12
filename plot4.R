## Read the file "household_power_consumption.txt"
householdpc <- read.table(file = "household_power_consumption.txt", sep = ";", na.strings = "?", 
                          header=TRUE)
## Add an extra column with a Date/Time variable
householdpc$TD <- strptime(paste(householdpc[,1], householdpc[,2], sep=","), 
                           format="%d/%m/%Y,%H:%M:%S")
## Extract wanted rows
twodays <- householdpc[householdpc[,10] >= as.POSIXlt("2007-02-01 00:00:00") &
                           householdpc[,10] <= as.POSIXlt("2007-02-02 23:59:00"), ]
## Open PNG device
png(filename = "plot4.png")
## Create plot
par(mfrow= c(2,2))
## Create plot1
with(twodays, plot(TD,Global_active_power, ylab="Global Active Power (kilowatts)", xlab = "" , 
                   type="l"))
## Create plot2
with(twodays, plot(TD,Voltage,xlab="datetime",ylab="Voltage",type="l"))
## Create plot3
with(twodays, plot(TD, Sub_metering_1 + Sub_metering_2 + Sub_metering_3, type= "n", xlab = "", 
                   ylab= "Energy sub metering"))
lines(twodays$TD,twodays$Sub_metering_1)
lines(twodays$TD,twodays$Sub_metering_2,col="red")
lines(twodays$TD,twodays$Sub_metering_3,col="blue")
plot_col <- c("black","red","blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=plot_col,lwd=2)
## Create plot4
with(twodays, plot(TD,Global_reactive_power, xlab="datetime", ylab="Global_reactive_power",type="l"))
## Close PNG file device
dev.off()