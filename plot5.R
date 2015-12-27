plot5 <- function(directory = "~/coursera/exploratory/ExData_Plotting2") {
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
  
  years <- c(1999,2002,2005,2008)
  options(digits=10)
  balMobileTotalEmissions <- c(sum(balMobileNEI[balMobileNEI$year==1999,]$Emissions), sum(balMobileNEI[balMobileNEI$year==2002,]$Emissions), sum(balMobileNEI[balMobileNEI$year==2005,]$Emissions), sum(balMobileNEI[balMobileNEI$year==2008,]$Emissions))
  # Plot 5
  png(filename="plot5.png", width=480, height=480)
  plot(years, balMobileTotalEmissions, col = 'red', xlab='Year', ylab='Total Emissions', main='Baltimore (fips == 24510) Total Mobile Emissions by Year', pch=19)
  lines(years, balMobileTotalEmissions, col = 'red')
  dev.off()
}