library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$type <- factor(NEI$type)
baltimore_la <- rbind(NEI[NEI$fips == '24510',], NEI[NEI$fips == '06037',])
motor_vehicle_types <- SCC[grep("Vehicles",SCC$SCC.Level.Two),]
motor_vehicle_observations <- merge(baltimore_la,motor_vehicle_types,by="SCC")
sumByYearsAndType <- aggregate(Emissions~year+fips, 
                               data=motor_vehicle_observations,
                               FUN=function(motor_vehicle_observations) 
                                 c(nonpoint=sum(motor_vehicle_observations)))
sumByYearsAndType$Emissions <- sumByYearsAndType$Emissions /1000
sumByYearsAndType$fips[sumByYearsAndType$fips=='06037']<-"Los Angeles County"
sumByYearsAndType$fips[sumByYearsAndType$fips=='24510']<-"Baltimore City"
names(sumByYearsAndType) <- gsub("fips", "Locations", names(sumByYearsAndType))
png(file = "plot6.png",height=400,width=700)
ggplot(data=sumByYearsAndType,aes(x=year, y=Emissions, colour=Locations)) + 
  geom_line() + ggtitle("Emissions From Motor Vehicle Sources") +
  scale_x_continuous(breaks=sort(unique(sumByYearsAndType$year)))+
  ylab("Emissions in kilotons")
dev.off()