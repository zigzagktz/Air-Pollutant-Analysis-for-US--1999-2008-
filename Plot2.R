df<- readRDS("summary.rds")
str(df)
sum(is.na(df))
library(dplyr)

average_by_year_baltimore<-df %>% filter(Pollutant=="PM25-PRI" & fips=="24510") %>% group_by(year) %>% summarise(value=mean(Emissions))
jpeg("Plot2.png")
plot(average_by_year_baltimore$year,average_by_year_baltimore$value,type="o",col="red",lwd=3,xlab="Year",ylab="Average Emission")
dev.off()