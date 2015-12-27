plot4 <- function(directory = "~/coursera/exploratory/ExData_Plotting2") {
  # Download file
  fileName <- paste(directory,"data.zip", sep="/")
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", fileName, method="curl")
  # Unzip file
  unzip(fileName) 
  # Read file
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  years <- c(1999,2002,2005,2008)
  # Find coal combustion related SCC
  coalSCC <- SCC[grep("Coal", SCC$EI.Sector),]
  # Find coal combustion related emissions
  coalNEI <- merge(NEI, coalSCC, all.x=FALSE, all.y=FALSE, by.x="SCC", by.y="SCC")
  
  options(digits=10)
  totalCoalEmissions <- c(sum(coalNEI[coalNEI$year==1999,]$Emissions), sum(coalNEI[coalNEI$year==2002,]$Emissions), sum(coalNEI[coalNEI$year==2005,]$Emissions), sum(coalNEI[coalNEI$year==2008,]$Emissions))
  # Plot 4
  png(filename="plot4.png", width=480, height=480)
  plot(years, totalCoalEmissions, col = 'green', xlab='Year', ylab='Total Coal Related Emissions', main='Total Coal Related Emissions by Year', pch=19)
  lines(years, totalCoalEmissions, col = 'green')
  dev.off()
}