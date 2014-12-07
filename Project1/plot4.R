# The input data file must be in the same directory as the R script
# The output PNG file is in the same directory as the R script.

library("dplyr")

household_power_consumption <- read.table("household_power_consumption.txt", sep=";" ,as.is=TRUE, header=TRUE)

household_power_consumption[household_power_consumption=="?"] <- NA

household_power_consumption$Date<-as.Date(household_power_consumption$Date, format="%d/%m/%Y")

household_power_consumption<-household_power_consumption %>%
        filter(Date == "2007-02-01" | Date == "2007-02-02")

household_power_consumption$DateTime <- 
        as.POSIXct(paste(household_power_consumption$Date, household_power_consumption$Time))

png(file="plot4.png",width=480,height=480)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

household_power_consumption %>%
with( {
        plot(Global_active_power~DateTime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~DateTime, type="l", ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~DateTime,col='Red')
        lines(Sub_metering_3~DateTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~DateTime, type="l", ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.off()