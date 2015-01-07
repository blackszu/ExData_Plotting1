## Coursera - Exploratory Data Analysis
## Course Project 1
#=================================================================================================
## Store the source data "household_power_consumption.txt" in R working directory
## The script (1) import source data;
##            (2) construct plot2 and send to plot2.png in R working directory (no plot appears on screen)
## Warning: output "plot2.png" will replace existing file with the same file name.
#=================================================================================================

#1.Import source data

    #1.1 load only first 100 rows to get column classes
    fid<- "household_power_consumption.txt"
    initial<- read.table(fid,header=TRUE,sep=";",nrow=100)
    classes<- sapply(initial,class)

    #1.2 read all data as text lines and keep only data from Date 1/2/2007 and 2/2/2007
    dataLines<- readLines(fid)
    dataLines<- dataLines[c(1,grep("^(1/2/2007|2/2/2007)",dataLines))]

    #1.3 convert text lines to data frame
    data<- read.table(textConnection(dataLines),head=TRUE,sep=";",colClasses=classes,comment.char="",na.strings="?")
    rm(list=setdiff(ls(), c("classes","data","fid")))
    
    #1.4 convert variables Date/Time from string to Date/POSIXlt format
    data$Time<- strptime(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")
    data$Date<- as.Date(data$Date,format="%d/%m/%Y")

#2. Plotting : create plot and send to a png file (no plot appears on screen)

    #2.1 open png device, create "plot2.png" in R working directory
    png(filename = "plot2.png",width = 480, height = 480, bg = "transparent")

    #2.2 plotting
    with(data,plot(data$Time,data$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="l"))

    #2.3 close png file device and set to default device   
    dev.off()
    dev.set(1)