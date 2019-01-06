df<- readRDS("summary.rds")
str(df)
sum(is.na(df))
library(dplyr)

LA <- df[df$fips=="06037",]
motor <- grepl("Vehicle",map$SCC.Level.Two)
sub_map <- map[motor,]

motor_merge_baltimore <- merge(sub_map,baltimore,by="SCC")
motor_merge_baltimore$fips <- "baltimore"

motor_merge_LA <- merge(sub_map,LA,by="SCC")
motor_merge_LA$fips <- "los angales"

r <- rbind(motor_merge_baltimore,motor_merge_LA)

agg <- aggregate(Emissions~year+fips,agg,sum)
jpeg("Plot6.png")
ggplot(agg,aes(year,Emissions,color=fips)) + geom_line()
dev.off()