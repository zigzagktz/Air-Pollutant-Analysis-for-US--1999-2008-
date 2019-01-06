df<- readRDS("summary.rds")
str(df)
sum(is.na(df))
library(dplyr)

motor <- grepl("Vehicle",map$SCC.Level.Two)
sub_map <- map[motor,]
motor_merge <- merge(sub_map,baltimore,by="SCC")
motor_emission_baltimore <- cbind(motor_merge$Emissions,motor_merge$year)

motor_year <- baltimore$year[as.character(baltimore$SCC)==as.character(motor)]
motor_Pollutant <- baltimore$Pollutant[baltimore$SCC==as.character(motor)]
baltimore_motor_by_year <- cbind(motor_year,motor_Pollutant)
motor_emission_baltimore <- as.data.frame(motor_emission_baltimore)
baltimore_emission_by_year <- motor_emission_baltimore %>% group_by(year) %>% summarise(value=sum(emission))
jpeg("Plot5.png")
plot(baltimore_emission_by_year,type="o",col="red",lwd=3)
dev.off()