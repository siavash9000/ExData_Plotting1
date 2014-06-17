library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$type <- factor(NEI$type)
coal_types <- merge(SCC[grep("Comb",SCC$Short.Name),],SCC[grep("Coal",SCC$Short.Name),])
coal_observations <- merge(NEI,coal_types,by="SCC")
sumByYears <- aggregate(Emissions~year, data=coal_observations, FUN=sum)
sumByYears$Emissions <- sumByYears$Emissions /1000
png(file = "plot4.png",height=700,width=900)
ggplot(data=sumByYears,aes(x=year, y=Emissions)) + 
  geom_line() + ggtitle("Emissions From Coal Combustion-Related Sources In US") + theme() +
  scale_x_continuous(breaks=sort(unique(sumByYears$year)))+
  ylab("Emissions in kilotons")
dev.off()