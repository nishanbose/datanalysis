cars = read.delim('cars.tsv',stringsAsFactors=FALSE)
cars
cars.data = cars[,c(3:8)]
rownames(cars.data) = cars$Car
cars.data
cars.data = scale(cars.data)

cars.dist = dist(cars.data)
cars.hclust <- hclust(cars.dist, method = "average")
plot(cars.hclust,labels=cars$Car,main='Hierarchical cluster analysis using average linkage')
groups.3 <- cutree(cars.hclust, k=3) # cut tree into 3 clusters
# draw dendogram with red borders around the 5 clusters 
rect.hclust(cars.hclust, k=3, border="red")
table(groups.3)
table(groups.3,cars$Country)

aggregate(cars[,c(3:8)], by = list(groups.3), FUN = median)

library(gplots)

heatmap.2(as.matrix(cars.data), hclustfun = function(x) hclust(x,method = "average"), 
          scale = "column", dendrogram="row", trace="none", density.info="none", 
          col=redblue(256), lhei=c(2,5.0), lwid=c(1.5,2.5), keysize = 0.25, 
          margins = c(5, 8), cexRow=0.7,cexCol=0.7)

library(cluster)
cars.pam = pam(cars.dist,3)
table(groups.3,cars.pam$clustering)

cars$Car[groups.3 != cars.pam$clustering]
cars$Car[cars.pam$id.med]
plot(cars.pam)
clusplot(cars.pam, labels=2)

silo = silhouette(cars.pam,cars.dist)
cars[silo[, "sil_width"]<0,]



