plot2 <- function(directory = "~/coursera/exploratory/ExData_Plotting2") {
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
  balTotalEmissions <- c(sum(balNEI[balNEI$year==1999,]$Emissions), sum(balNEI[balNEI$year==2002,]$Emissions), sum(balNEI[balNEI$year==2005,]$Emissions), sum(balNEI[balNEI$year==2008,]$Emissions))
  # Plot 2
  png(filename="plot2.png", width=480, height=480)
  plot(years, balTotalEmissions, col = 'red', xlab='Year', ylab='Total Emissions', main='Baltimore (fips == 24510) Total Emissions by Year', pch=19)
  lines(years, balTotalEmissions, col = 'red')
  dev.off()
}