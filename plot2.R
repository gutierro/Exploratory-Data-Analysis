# The input data file must be in the same directory as the R script
# The output PNG file is in the same directory as the R script.

library("dplyr")

household_power_consumption <- read.table("household_power_consumption.txt", sep=";" ,as.is=TRUE, header=TRUE)

household_power_consumption[household_power_consumption=="?"] <- NA

household_power_consumption$Date<-as.Date(household_power_consumption$Date, format="%d/%m/%Y")

household_power_consumption<-household_power_consumption %>%
        filter(Date == "2007-02-01" | Date == "2007-02-02")

png(file="plot2.png",width=480,height=480)

household_power_consumption$DateTime <- 
        as.POSIXct(paste(household_power_consumption$Date, household_power_consumption$Time))

plot(household_power_consumption$Global_active_power~household_power_consumption$DateTime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

dev.off()