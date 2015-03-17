data = read.table("countrydata_withregion.tsv", header = TRUE, sep = "\t", quote = "\"", dec = ".", fill = TRUE, comment.char = "")
#data = read.delim("countrydata_withregion.tsv")
head(data,n=15)

#scatterplot
data.scatter = data.frame(country=data$country, log_area=(log(data$area)), log_popu=(log(data$population)))
plot(data.scatter$log_area, data.scatter$log_popu)

#pie-area
data.aggarea = aggregate(data$area, by = list(data$region), FUN = sum)
pie(data.aggarea$x, labels=data.aggarea$Group.1)

#pie-population
data.aggpop = aggregate(data$population, by=list(data$region), FUN = function(x){sum(as.numeric(x))})
pie(data.aggpop$x, labels=data.aggpop$Group.1)

#pop-per-sq
data.density = data.frame(region=data.aggpop$Group.1, density=(data.aggpop$x/data.aggarea$x))
sorted.des <- data.density[order(-data.density$density),]
barplot(sorted.des$density, names.arg=sorted.des$region, cex.names=0.75)
