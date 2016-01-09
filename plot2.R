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

png("./ExData_Plotting1/plot2.png", width = 480, height = 480)

with(energy, plot(datetime, Global_active_power, type = "l",
                  xlab = "", ylab = "Global Active Power (kilowatts)"))

#lines(Global_active_power~DateTime)
dev.off()