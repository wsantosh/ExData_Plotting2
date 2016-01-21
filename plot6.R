## This is my Assignment: Assignment: Course Project 2 for Exploratory-data-analysis

##make sure the dataset file is downloaded on correct directory
##https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
##1. 𝚜𝚞𝚖𝚖𝚊𝚛𝚢𝚂𝙲𝙲_𝙿𝙼𝟸𝟻.𝚛𝚍𝚜
##This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. 
##For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for 
##the entire year. Here are the first few rows.

##2. 𝚂𝚘𝚞𝚛𝚌𝚎_𝙲𝚕𝚊𝚜𝚜𝚒𝚏𝚒𝚌𝚊𝚝𝚒𝚘𝚗_𝙲𝚘𝚍𝚎.𝚛𝚍𝚜
##This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the 
##PM2.5 source. The sources are categorized in a few different ways from more general to more specific and 
##you may choose to explore whatever categories you think are most useful. For example, source “10100101” is 
##known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

## This first line will likely take a few secoAssignment:- 
##The overall goal of this assignment is to explore the National Emissions Inventory database and see what 
##it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. 
##You may use any R package you want to support your analysis.

##6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
##in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes over time 
##in motor vehicle emissions?

##get ggplot2 package
library(ggplot2)
library(plyr)


##nmake sure your working direcoty is correct
getwd()

##File Name
fileName <- "plot6.png"

## ds. Be patient!
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
# head(NEI)

#total motor vehicle emissions for Baltimore city, Maryland(fips=="24510") & los angeles Californiya(fips=="06037")
emissionsBmLaData <- NEI[(NEI$fips=="24510" | NEI$fips=="06037" ),] 

totalEmissionsData <- aggregate(emissionsBmLaData$Emissions, by=list(emissionsBmLaData$year,emissionsBmLaData$fips), sum)
#give proper heading for all columns
names(totalEmissionsData) <- c("Year", "Cities", "Emissions")

## replace appropreate naming for Rows
totalEmissionsData$Cities[(totalEmissionsData$Cities=="06037")] <- "Baltimore City"
totalEmissionsData$Cities[(totalEmissionsData$Cities=="24510")] <- "Los Angeles County"
##totalEmissionsData

##Construct the plot and save it to a PNG file with a width of 480 pixels and 
##a height of 480 pixels and write
png(fileName, width=480, height=480)

## plot graph with proper color and Labaling for Baltimore City. 
##Constructed using the ggplot2 plotting system
ggplot(data=totalEmissionsData, aes(x=Year, y=Emissions)) +
  geom_point() + geom_line() + facet_grid(. ~ Cities) + xlab("Year") + ylab("Total PM2.5 Emission(Tons)") +
  ggtitle("Total PM2.5 Emissions(tons) from Motor Cehicle for Baltimore City and  Los Angeles County Per Year")

##Close off the ploting device
dev.off()
