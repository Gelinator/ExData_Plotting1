#wd is the filepath as a string where the files will be saved

plot4 <- function(wd){
        
        setwd(wd) #setting working directory
        
        name = "exdata_plotting1.zip" #setting name of zipped file to be used later on
        
        
        #verifying if file is present in working directory. Else, downloads it.
        if (!file.exists(name)){
                fhandle <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                                         destfile=name, method="curl")
        }
        
        
        #loading the data in environment
        data <- read.csv(unz(name, "household_power_consumption.txt"), sep = ";",na.strings="?",
                         colClasses=c("character", "character", rep("numeric",7)))
        
        #converting Date column to date format
        data$combined = strptime(paste(data[,1],data[,2]),
                                 format="%d/%m/%Y %H:%M:%S", tz="EST")
        
        #subsetting the data to the specified dates
        Data <- subset(data,data$combined >= "2007/02/01 00:00:00" & data$combined <"2007/02/03 00:00:00") #Adjust the date parameters
        
        #creating the PNG image file
        png(filename = "Plot4.png", width = 480, height = 480,bg="transparent")
        
        #creating 2x2 frame for the four plots
        par(mfrow=c(2,2))                
        
        #function to create plot1
        plot1 <- function(){
                plot(Data$combined, Data$Global_active_power, type="l", xlab="",
                     ylab="Global Active Power")
        }
        plot1() #returning plot1
        
        
        #function to create plot2
        plot2 <- function(){
                plot(Data$combined, Data$Voltage, type="l", xlab="datetime",
                     ylab="Voltage")
        }
        plot2() #returning plot2
        
        #function to create plot3
        plot3 <- function(){
                plot(Data$combined, Data$Sub_metering_1, type="l", xlab="",
                     ylab="Energy sub metering")
                legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                       lty=c(1,1,1),lwd=c(1,1,1),col=c("black","red","blue"),bty="n")
                lines(Data$combined, Data$Sub_metering_2, col="red")
                lines(Data$combined, Data$Sub_metering_3, col="blue")
        }
        plot3() #returning plot3
        
        #function to create the final plot
        plotted4 <- function(){
                plot(Data$combined, Data$Global_reactive_power, type="l", xlab="datetime",
                     ylab="Global_reactive_power")
        }
        #returning the final plot
        plotted4()
        
        #finishing off
        dev.off()        
}