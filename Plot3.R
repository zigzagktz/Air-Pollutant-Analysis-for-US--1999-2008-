df<- readRDS("summary.rds")
str(df)
sum(is.na(df))
library(dplyr)

baltimore <- df[df$fips=="24510",]
baltimore_avg <- baltimore %>% group_by(year,type) %>% summarise(value=mean(Emissions))
jpeg("Plot3.png")
ggplot(baltimore_avg,aes(year,value,color=type),ylim(20)) + geom_point() + geom_line()
dev.off()