###############################################################################
####Plot 4 for Course Project 1 has a total of 4 graphs on one page. ##########
###############################################################################

## Read in the Electric Power Data Consumption file which has been unzipped
## added the na.string argument so it knows that "?" should be treat as NA values
EP.Dataset <- read.table("./EDA/household_power_consumption.txt", sep=";",
              header = TRUE, as.is = TRUE, na.string = "?" )

colnames(EP.Dataset)    # to view colnames of the data
class(EP.Dataset$Date)  # Date class is a character

# the format specified in the as.Date function has to be the format in the original data
EP.Dataset$Date <- as.Date(EP.Dataset$Date,"%d/%m/%Y")
class(EP.Dataset$Date)   #  verifying that Date is now a Date class                                                   

head(EP.Dataset$Date)    # to view what the date format looks like

# Need the data between Feb 1 and 2 of 2007 only
EPData <-subset(EP.Dataset, Date >= "2007-02-01" & Date <= "2007-02-02")
nrow(EPData)   # 2880 rows
class(EPData$Global_active_power)  # character.  Needs to converted to numeric.

# changing  the class of the Global Active Power column from character to numeric
EPData$Global_active_power <- as.numeric(EPData$Global_active_power)
class(EPData$Global_active_power)  # numeric.  Confirming

## Joining the date and time to create a new column called "DateTime"
EPData$DateTime <- as.POSIXct(paste(EPData$Date, EPData$Time),
					 format="%Y-%m-%d %H:%M:%S")
head(EPData)  # confirmed the new column was created


#Plotting the 4 graphs
## Graph 1 on the tope left of the page is plot 2
par(mfcol = c(2,2), bg = "white")
with(EPData, plot(DateTime,Global_active_power,type= "l", 
			ylab = "Global Active Power",
                  xlab =""))

## Graph 2 on the bottom left of the page is actually plot 3
with(EPData,plot(DateTime,Sub_metering_1,type="l",col="black",
                 ylab = "Energy sub metering", xlab= ""))

lines(EPData$DateTime,EPData$Sub_metering_2,col="red") 
lines(EPData$DateTime,EPData$Sub_metering_3,col="blue")
## added the cex argument for the legend to be smaller
legend("topright",legend=c("Sub_metering_1","Sub_metering_2",
	 "Sub_metering_3"), col=c("black","red","blue"),lty = 1,
	 bty = "n", cex= 0.8)


## Graph 3 on the top right of the page

with(EPData, plot(DateTime,Voltage,type= "l", 
			ylab = "Voltage",
                  xlab ="datetime"))

## Graph 4 on the bottom right of the page
par(cex.axis = 0.8)  ## added this so the size is smaller and 0.5 is displayed
with(EPData, plot(DateTime,Global_reactive_power,type= "l", 
			ylab = "Global_reactive_power",
                  xlab ="datetime"))

# tried using bg= "white" in the function below but it did not work.
# I added the bg="white in the par funtion before starting the first plot


## Added the res argument so that the legend in the 2nd plot is more to the top right
## in the png file.
dev.copy(png, "./EDA/ExData_Plotting1/plot4.png",
    width = 480, height = 480, res=85)
dev.off()  # turn off device

