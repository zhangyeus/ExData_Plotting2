mobileSCC<- SCC[SCC$SCC.Level.One=="Mobile Sources",]

plot6 <- function(directory = "~/coursera/exploratory/ExData_Plotting2") {
  # Download file
  fileName <- paste(directory,"data.zip", sep="/")
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", fileName, method="curl")
  # Unzip file
  unzip(fileName) 
  # Read file
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  # Find SCC from mobile sources
  mobileSCC<- SCC[SCC$SCC.Level.One=="Mobile Sources",]
  # Find Baltimore emissions
  balNEI <- NEI[NEI$fips == "24510",]
  # Find Baltimore mobile emissions
  balMobileNEI <- merge(balNEI, mobileSCC, all.x=FALSE, all.y=FALSE, by.x="SCC", by.y="SCC")
  # Find Los Angels emissions
  losNEI <- NEI[NEI$fips == "06037",]
  # Find Baltimore mobile emissions
  losMobileNEI <- merge(losNEI, mobileSCC, all.x=FALSE, all.y=FALSE, by.x="SCC", by.y="SCC")
  
  years <- c(1999,2002,2005,2008)
  options(digits=10)
  balMobileTotalEmissions <- c(sum(balMobileNEI[balMobileNEI$year==1999,]$Emissions), sum(balMobileNEI[balMobileNEI$year==2002,]$Emissions), sum(balMobileNEI[balMobileNEI$year==2005,]$Emissions), sum(balMobileNEI[balMobileNEI$year==2008,]$Emissions))
  losMobileTotalEmissions <- c(sum(losMobileNEI[losMobileNEI$year==1999,]$Emissions), sum(losMobileNEI[losMobileNEI$year==2002,]$Emissions), sum(losMobileNEI[losMobileNEI$year==2005,]$Emissions), sum(losMobileNEI[losMobileNEI$year==2008,]$Emissions))
  
  comparisonMobileEmissions <- data.frame(Year=years, Total_Emissions=balMobileTotalEmissions, City=rep("Baltimore", each=4))
  comparisonMobileEmissions <- rbind(comparisonMobileEmissions, data.frame(Year=years, Total_Emissions=losMobileTotalEmissions, City=rep("Los Angels", each=4)))
  
  # Plot 6
  library(ggplot2)
  png(filename="plot6.png", width=480, height=480)
  qplot(Year, Total_Emissions, data=comparisonMobileEmissions, col = City, facets=.~City, geom=c("line"))
  dev.off()
}