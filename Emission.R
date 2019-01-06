

df<- readRDS("summary.rds")
str(df)
sum(is.na(df))
library(dplyr)

##1
average_by_year<- df %>% filter(Pollutant=="PM25-PRI") %>% group_by(year) %>% summarise(value=mean(Emissions))
jpeg("1st.png")
plot(average_by_year$year,average_by_year$value,type="o",col="red",lwd=3,xlab="Year",ylab="Average Emission")
dev.off()

##2
average_by_year_baltimore<-df %>% filter(Pollutant=="PM25-PRI" & fips=="24510") %>% group_by(year) %>% summarise(value=mean(Emissions))
plot(average_by_year_baltimore$year,average_by_year_baltimore$value,type="o",col="red",lwd=3,xlab="Year",ylab="Average Emission")

baltimore <- df[df$fips=="24510",]
baltimore_avg <- baltimore %>% group_by(year,type) %>% summarise(value=mean(Emissions))
ggplot(baltimore_avg,aes(year,value,color=type),ylim(20)) + geom_point() + geom_line()

##4
map$Short.Name <- as.character(map$Short.Name)
coal <- grepl("Coal",map$Short.Name)
coal_map <- map[coal,]

US_coal_emission <- merge(coal_map,df,by="SCC")
US_coal_each_year <- US_coal_emission %>% group_by(year) %>% summarise(value=mean(Emissions))
plot(US_coal_each_year$year,US_coal_each_year$value,type="o",col="red",lwd=3)

##5 have to change the solution
motor <- grepl("Vehicle",map$SCC.Level.Two)
sub_map <- map[motor,]
motor_merge <- merge(sub_map,baltimore,by="SCC")
motor_emission_baltimore <- cbind(motor_merge$Emissions,motor_merge$year)

motor_year <- baltimore$year[as.character(baltimore$SCC)==as.character(motor)]
motor_Pollutant <- baltimore$Pollutant[baltimore$SCC==as.character(motor)]
baltimore_motor_by_year <- cbind(motor_year,motor_Pollutant)
motor_emission_baltimore <- as.data.frame(motor_emission_baltimore)
baltimore_emission_by_year <- motor_emission_baltimore %>% group_by(year) %>% summarise(value=sum(emission))
plot(baltimore_emission_by_year,type="o",col="red",lwd=3)


#6
LA <- df[df$fips=="06037",]
motor <- grepl("Vehicle",map$SCC.Level.Two)
sub_map <- map[motor,]

motor_merge_baltimore <- merge(sub_map,baltimore,by="SCC")
motor_merge_baltimore$fips <- "baltimore"

motor_merge_LA <- merge(sub_map,LA,by="SCC")
motor_merge_LA$fips <- "los angales"

r <- rbind(motor_merge_baltimore,motor_merge_LA)

agg <- aggregate(Emissions~year+fips,agg,sum)
ggplot(agg,aes(year,Emissions,color=fips)) + geom_line()




