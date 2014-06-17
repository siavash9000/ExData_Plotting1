NEI <- readRDS("summarySCC_PM25.rds")
sumByYears <- aggregate(Emissions~year, data=NEI, FUN=sum)
sumByYears$Emissions <- sumByYears$Emissions /1000
png(file = "plot1.png")
with(sumByYears,plot(x=year,y=Emissions, ylab="kilotons",type='b',xlab="",xaxt="n",main="Total Emissions in US"),las=2)
axis(1,at=sumByYears$year,labels=sumByYears$year)
dev.off()