NEI <- readRDS("summarySCC_PM25.rds")
sumByYears <- aggregate(Emissions~year, data=subset(NEI,fips == 24510), FUN=sum)
sumByYears$Emissions <- sumByYears$Emissions /1000
png(file = "plot2.png")
with(sumByYears,plot(x=year,y=Emissions, ylab="kilotons",type='b',xlab="",xaxt="n",main="Total Emissions in Baltimore City"),las=2)
axis(1,at=sumByYears$year,labels=sumByYears$year)
dev.off()