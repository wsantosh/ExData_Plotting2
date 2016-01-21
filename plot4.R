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

##4.Across the United States, how have emissions from coal combustion-related sources 
##changed from 1999–2008?.

##get ggplot2 package
library(ggplot2)
library(plyr)


##nmake sure your working direcoty is correct
getwd()

##File Name
fileName <- "plot4.png"

## ds. Be patient!
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
# head(NEI)

#get all Coal related names from SCC  file
coalSourcesData <- SCC[grep("^Coal ", SCC$Short.Name, ignore.case=F),"SCC"]

#Now filter out all related emission sources for all the above Coal Sources
##also funcation(df) is use to cum all emissions data
coalCombustionData <- ddply(NEI[NEI$SCC %in% coalSourcesData,], c("year"), function(df)sum(df$Emissions, na.rm=TRUE))

#head(coalCombustionData)

#give proper heading for all columns
names(coalCombustionData) <- c("Year", "Emissions")

##Construct the plot and save it to a PNG file with a width of 480 pixels and 
##a height of 480 pixels and write
png(fileName, width=480, height=480)

## plot graph with proper color and Labaling for coal combustion. 
##Constructed using the ggplot2 plotting system

ggplot(data=coalCombustionData, aes(x=Year, y=Emissions)) +
  geom_line() + xlab("Year") + ylab("Total PM2.5 Emission(Tons)") +
  ggtitle("Total PM2.5 Emissions(tons) for Coal Combustion")

##Close off the ploting device
dev.off()
