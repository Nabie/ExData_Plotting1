#Download the file in Graph directory
if (!file.exists("Graph")){ dir.create("Graph")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, 
              destfile = "./Graph/household_power_consumption.zip", mode = "wb")

#unzip the file
unzip("./Graph/household_power_consumption.zip", 
      "household_power_consumption.txt", exdir = "./Graph")

# loading sqlf
library(sqldf)
#library(tcltk)

# readind only data  from the dates 2007-02-01 and 2007-02-02
energy <- read.csv.sql("./Graph/household_power_consumption.txt",
sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
  header = TRUE, sep = ";")

closeAllConnections()

# creating a variable datetime pasting date and time variables 
energy$datetime <- paste(energy$Date, energy$Time)

#converting datetime to class date time
energy$datetime <- strptime(energy$datetime, "%d/%m/%Y %H:%M:%S")

# creating the graph in the clonned repo ExData_Plotting1

png("./ExData_Plotting1/plot3.png", width = 480, height = 480)

with(energy, {
  plot(datetime, Sub_metering_1, type = "l",
       xlab = "", ylab = "Energie sub metering")
  lines(datetime, Sub_metering_2, type = "l", col = "red")
  lines(datetime, Sub_metering_3, type = "l", col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

dev.off()