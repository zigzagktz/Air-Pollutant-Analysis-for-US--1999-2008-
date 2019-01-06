df<- readRDS("summary.rds")
str(df)
sum(is.na(df))
library(dplyr)

map$Short.Name <- as.character(map$Short.Name)
coal <- grepl("Coal",map$Short.Name)
coal_map <- map[coal,]

US_coal_emission <- merge(coal_map,df,by="SCC")
US_coal_each_year <- US_coal_emission %>% group_by(year) %>% summarise(value=mean(Emissions))
jpeg("Plot4.png")
plot(US_coal_each_year$year,US_coal_each_year$value,type="o",col="red",lwd=3)
dev.off()