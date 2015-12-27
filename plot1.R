plot1 <- function(directory = "~/coursera/exploratory/ExData_Plotting2") {
  # Download file
  fileName <- paste(directory,"data.zip", sep="/")
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", fileName, method="curl")
  # Unzip file
  unzip(fileName) 
  # Read file
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  years <- c(1999,2002,2005,2008)
  options(digits=10)
  totalEmissions <- c(sum(NEI[NEI$year==1999,]$Emissions), sum(NEI[NEI$year==2002,]$Emissions), sum(NEI[NEI$year==2005,]$Emissions), sum(NEI[NEI$year==2008,]$Emissions))
  # Plot 1
  png(filename="plot1.png", width=480, height=480)
  plot(years, totalEmissions, col = 'green', xlab='Year', ylab='Total Emissions', main='Total Emissions by Year', pch=19)
  lines(years, totalEmissions, col = 'green')
  dev.off()
}