library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$type <- factor(NEI$type)
baltimore <- subset(NEI,fips == 24510)
motor_vehicle_types <- SCC[grep("Vehicles",SCC$SCC.Level.Two),]
motor_vehicle_observations <- merge(baltimore,motor_vehicle_types,by="SCC")
sumByYears <- aggregate(Emissions~year, data=motor_vehicle_observations, FUN=sum)
png(file = "plot5.png",height=400,width=600)
ggplot(data=sumByYears,aes(x=year, y=Emissions)) + 
  geom_line() + ggtitle("Emissions From Motor Vehicle Sources In Baltimore") + theme() +
  scale_x_continuous(breaks=sort(unique(sumByYears$year)))+
  ylab("Emissions in tons")
dev.off()