#wd is the filepath as a string where the files will be saved

plot2 <- function(wd){
        
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
        
        #creating a new column with the complete time data (date and time), and changing format to date
        data$combined = strptime(paste(data[,1],data[,2]),
                                 format="%d/%m/%Y %H:%M:%S", tz="EST")
        #subsetting the data to the specified dates
        Data <- subset(data,data$combined >= "2007/02/01 00:00:00" & data$combined <"2007/02/03 00:00:00") #Adjust the date parameters
        
        #creating the PNG image file
        png(filename = "Plot2.png", width = 480, height = 480,bg="transparent")
        
        #plotting the data
        plot(Data$combined, Data$Global_active_power, type="l", xlab="",
             ylab="Global Active Power (kilowatts)")
        #finishing off
        dev.off()        
}