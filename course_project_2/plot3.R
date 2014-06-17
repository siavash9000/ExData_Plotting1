library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
NEI$type <- factor(NEI$type)
baltimore <- subset(NEI,fips == 24510)
sumByYearsAndType <- aggregate(Emissions~year+type, data=baltimore,FUN=function(baltimore) c(nonpoint=sum(baltimore)))
sumByYearsAndType$Emissions <- sumByYearsAndType$Emissions /1000
png(file = "plot3.png",height=700,width=900)
ggplot(data=sumByYearsAndType,aes(x=year, y=Emissions, colour=type)) + 
  geom_line() + ggtitle("Emissions by type in Baltimore") + theme() +
  scale_x_continuous(breaks=sort(unique(sumByYearsAndType$year)))+
  ylab("Emissions in kilotons")
dev.off()