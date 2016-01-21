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

##3. Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) variab
##le, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
##Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
##answer this question.

##get ggplot2 package
library(ggplot2)

##nmake sure your working direcoty is correct
getwd()

##File Name
fileName <- "plot3.png"

## ds. Be patient!
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
# head(NEI)

##total emissions for Valtimore city, Maryland(fips=="24510")
baltimoreNEIData <- NEI[(NEI$fips=="24510"),]
totalBaltimoreEmissionsData <- aggregate(baltimoreNEIData$Emissions, by=list(baltimoreNEIData$year, baltimoreNEIData$type), sum, na.rm = TRUE)


#give proper heading for all columns
names(totalBaltimoreEmissionsData) <- c("Year", "Type", "Emissions")

##Construct the plot and save it to a PNG file with a width of 480 pixels and 
##a height of 480 pixels and write
png(fileName, width=480, height=480)

## plot graph with proper color and Labaling bor Baltimore City. 
##Constructed using the ggplot2 plotting system

# #put year ans emissions data on graph using ggplot
# ggplot <- ggplot(totalBaltimoreEmissionsData, aes(Year,Emissions))
# #put data in form of point on graph
# ggplot <- ggplot + geom_point()
# #drow line between points
# ggplot <- ggplot + geom_line()
# #separate the plot base on type
# ggplot <- ggplot + facet_grid(. ~ Type)
# ##Apply proper labeling/heading.
# ggplot + xlab("Year") + ylab("Total PM2.5 Emission(Tons)") + ggtitle("Total PM2.5 Emissions(tons) for Baltimore City Per Year by Source Type")

## OR

ggplot(data=totalBaltimoreEmissionsData, aes(x=Year, y=Emissions, group=Type, colour=Type)) +
  geom_line() + xlab("Year") + ylab("Total PM2.5 Emission(Tons)") +
  ggtitle("Total PM2.5 Emissions(tons) for Baltimore City Per Year by Source Type")

##Close off the ploting device
dev.off()
