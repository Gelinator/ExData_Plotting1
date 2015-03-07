#wd is the filepath as a string where the files will be saved

plot1 <- function(wd){
        
        setwd(wd) #setting working directory
        
        name = "exdata_plotting1.zip" #setting name of zipped file to be used later on
        
        
        #verifying if file is present in working directory. Else, downloads it.
        if (!file.exists(name)){
                fhandle <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                                         destfile=name, method="curl")
        }
        
        #loading the data in environment
        data <- read.csv(unz(name, "household_power_consumption.txt"), sep = ";",na.strings="?")
        
        #converting Date column to date format
        data$Date <- strptime(data$Date, format="%d/%m/%Y")
        
        #subsetting the data to the specified dates
        Data <- subset(data,data$Date >="2007-02-01" & data$Date <="2007-02-02")
        
        #creating the PNG image file
        png(filename = "Plot1.png",
            width = 480, height = 480,bg="transparent")
        
        #plotting the data as an histogram
        hist(Data$Global_active_power,
             xlab = "Global Active Power (kilowatts)",
             main="Global Active Power",col="red")
        #finishing off
        dev.off()        
}