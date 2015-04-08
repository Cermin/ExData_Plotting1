########################################################################################
###########################Plot 1 for Course Project 1  ################################
########################################################################################

## Read in the Electric Power Data Consumption file which has been unzipped
## added the na.string argument so it knows that "?" should be treat as NA values
EP.Dataset <- read.table("./EDA/household_power_consumption.txt", sep=";",
              header = TRUE, as.is = TRUE , na.string = "?")
colnames(EP.Dataset)    # to view colnames of the data
class(EP.Dataset$Date)  # Date class is a character

# the format specified in the as.Date function has to be the format in the original data
EP.Dataset$Date <- as.Date(EP.Dataset$Date,"%d/%m/%Y")
class(EP.Dataset$Date)   #  verifying that Date is now a Date class                                                   

head(EP.Dataset$Date)    # to view what the date format looks like

# Need the data between Feb 1 and 2 of 2007 only
EPData <-subset(EP.Dataset, Date >= "2007-02-01" & Date <= "2007-02-02")
nrow(EPData)   # 2880 rows
class(EPData$Global_active_power)  # numeric  

#Plotting the histogram
par(bg = "white")
hist(EPData$Global_active_power,col = "red",freq = TRUE, 
		main = "Global Active Power" , 
            ylab = "Frequency",
            xlab = "Global Active Power (kilowatts)",
            ylim=c(0, 1200))
            
# tried using bg= "white" in the function below but it did not work.
# I added the bg="white in the par funtion before starting the plot function
dev.copy(png, "./EDA/ExData_Plotting1/plot1.png",
    width = 480, height = 480, res =85)
dev.off()  # turn off device


