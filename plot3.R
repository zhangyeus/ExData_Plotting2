plot3 <- function(directory = "~/coursera/exploratory/ExData_Plotting2") {
  # Download file
  fileName <- paste(directory,"data.zip", sep="/")
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", fileName, method="curl")
  # Unzip file
  unzip(fileName) 
  # Read file
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  # Find Baltimore emissions
  balNEI <- NEI[NEI$fips == "24510",]
  
  years <- c(1999,2002,2005,2008)
  options(digits=10)
  balPointTotalEmissions <- c(sum(balNEI[balNEI$year==1999 & balNEI$type == "POINT",]$Emissions), sum(balNEI[balNEI$year==2002 & balNEI$type == "POINT",]$Emissions), sum(balNEI[balNEI$year==2005 & balNEI$type == "POINT",]$Emissions), sum(balNEI[balNEI$year==2008 & balNEI$type == "POINT",]$Emissions))
  balNonPointTotalEmissions <- c(sum(balNEI[balNEI$year==1999 & balNEI$type == "NONPOINT",]$Emissions), sum(balNEI[balNEI$year==2002 & balNEI$type == "NONPOINT",]$Emissions), sum(balNEI[balNEI$year==2005 & balNEI$type == "NONPOINT",]$Emissions), sum(balNEI[balNEI$year==2008 & balNEI$type == "NONPOINT",]$Emissions))
  balOnRoadTotalEmissions <- c(sum(balNEI[balNEI$year==1999 & balNEI$type == "ON-ROAD",]$Emissions), sum(balNEI[balNEI$year==2002 & balNEI$type == "ON-ROAD",]$Emissions), sum(balNEI[balNEI$year==2005 & balNEI$type == "ON-ROAD",]$Emissions), sum(balNEI[balNEI$year==2008 & balNEI$type == "ON-ROAD",]$Emissions))
  balNonRoadTotalEmissions <- c(sum(balNEI[balNEI$year==1999 & balNEI$type == "NON-ROAD",]$Emissions), sum(balNEI[balNEI$year==2002 & balNEI$type == "NON-ROAD",]$Emissions), sum(balNEI[balNEI$year==2005 & balNEI$type == "NON-ROAD",]$Emissions), sum(balNEI[balNEI$year==2008 & balNEI$type == "NON-ROAD",]$Emissions))
  
  balEmissionsByType <- data.frame(Year=years, Total_Emissions=balPointTotalEmissions, Type=rep("POINT", each=4))
  balEmissionsByType <- rbind(balEmissionsByType, data.frame(Year=years, Total_Emissions=balNonPointTotalEmissions, Type=rep("NONPOINT", each=4)))
  balEmissionsByType <- rbind(balEmissionsByType, data.frame(Year=years, Total_Emissions=balOnRoadTotalEmissions, Type=rep("ON-ROAD", each=4)))
  balEmissionsByType <- rbind(balEmissionsByType, data.frame(Year=years, Total_Emissions=balNonRoadTotalEmissions, Type=rep("NON-ROAD", each=4)))
  
  # Plot 3
  library(ggplot2)
  png(filename="plot3.png", width=640, height=480)
  qplot(Year, Total_Emissions, data=balEmissionsByType, col = Type, facets=.~Type, geom=c("line"))
  dev.off()
}