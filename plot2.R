#       reading only first row
data <- read.table("household_power_consumption.txt",header = TRUE,sep = ";",
                   nrows = 1,stringsAsFactors = FALSE)

#       calculating rows to be skipped
start <- as.POSIXct(paste(data$Date[1],data$Time[1],sep = " "),
                    format="%d/%m/%Y %H:%M:%S")
end <- as.POSIXct("2007-02-01 00:00:00")
skip <- as.numeric((end-start)*24*60)

#       calculating rows to be read
start <- as.Date("2007-02-01")
end <- as.Date("2007-02-03")
nrows <- as.numeric((end-start)*24*60)


#       read data from 2007-02-01 and 2007-02-02
data <- read.table("household_power_consumption.txt",header = TRUE,sep = ";",
                   skip = skip, nrows = nrows,stringsAsFactors = FALSE, 
                   col.names=colnames(data))
#       adding an extra col with data-time
data["Date_Time"] <- with(data,as.POSIXct(paste(Date,Time,sep=" "),
                                          format="%d/%m/%Y %H:%M:%S"))


plot(data$Date_Time,data$Global_active_power,type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")


#       storing the plot in png file
dev.copy(png,file="plot2.png")
dev.off()