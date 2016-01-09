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

# creating the graph in the clonned repo ExData_Plotting1

png("./ExData_Plotting1/plot1.png", width = 480, height = 480)

with(energy, hist(Global_active_power, col = "red",
                  main = "Global Active Power", 
                  xlab ="Global Active Power (kilowatts)" ))

dev.off()
