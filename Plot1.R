df<- readRDS("summary.rds")
str(df)
sum(is.na(df))
library(dplyr)

average_by_year<- df %>% filter(Pollutant=="PM25-PRI") %>% group_by(year) %>% summarise(value=mean(Emissions))
jpeg("Plot1.png")
plot(average_by_year$year,average_by_year$value,type="o",col="red",lwd=3,xlab="Year",ylab="Average Emission")
dev.off()