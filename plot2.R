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
png(filename = "plot2.png")
## Create plot
with(twodays, plot(TD,Global_active_power, ylab="Global Active Power (kilowatts)", xlab = "" , 
                   type="l"))
## Close PNG file device
dev.off()