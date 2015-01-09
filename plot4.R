## Coursera - Exploratory Data Analysis
## Course Project 1
#=================================================================================================
## Store the source data "household_power_consumption.txt" in R working directory. If the source data file
## does not exist in R working directory, the script will unzip/download from the source url.

## The script (1) downloads/imports source data;
##            (2) construct plot4 and send to plot4.png in R working directory (no plot appears on screen)

## Warning: output "plot4.png" will replace existing file with the same file name.
#=================================================================================================

#1.Import source data

    url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    zip<- "exdata-data-household_power_consumption.zip"
    fid<- "household_power_consumption.txt"
    
    #1.1 check if source data file already exists. If not, download from url and/or unzip
    if (!file.exists(fid)) {
        if (!file.exists(zip)) {
            download.file(url,destfile=zip)
        }
        unzip(zip)
    }
    
    #1.2 load only first 100 rows to get column classes
    initial<- read.table(fid,header=TRUE,sep=";",nrow=100)
    classes<- sapply(initial,class)
    
    #1.3 read all data as text lines and select only data from Date 1/2/2007 and 2/2/2007
    dataLines<- readLines(fid)
    dataLines<- dataLines[c(1,grep("^(1/2/2007|2/2/2007)",dataLines))]

    #1.4 convert text lines to data frame
    data<- read.table(textConnection(dataLines),head=TRUE,sep=";",colClasses=classes,comment.char="",na.strings="?")
    rm(list=setdiff(ls(), c("classes","data","fid")))
    
    #1.5 convert variables Date/Time from string to Date/POSIXlt format
    data$Time<- strptime(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")
    data$Date<- as.Date(data$Date,format="%d/%m/%Y")

#2. Plotting : create plot and send to a png file (no plot appears on screen)

    #2.1 open png device, create "plot4.png" in R working directory
    png(filename = "plot4.png",width = 480, height = 480, bg = "transparent")

    #2.2 plotting
    par(mfrow=c(2,2),mar=c(5,4,4,1.5))
    with(data, {
        plot(data$Time,data$Global_active_power,xlab="",ylab="Global Active Power",type="l")
        plot(data$Time,data$Voltage,xlab="datetime",ylab="Voltage",type="l")
        plot(data$Time,data$Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering")
        lines(data$Time,data$Sub_metering_2,col="red")
        lines(data$Time,data$Sub_metering_3,col="blue")
        legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,
           col=c("black","red","blue"),box.lty=0)
        plot(data$Time,data$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")
    })

    #2.3 close png file device and set to default device  
    dev.off()
    dev.set(1)