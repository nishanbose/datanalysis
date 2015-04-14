library(gplots)

data.input <- read.table("Figure2.txt", header = TRUE, sep = "\t", quote = "\"", dec = ".", fill = TRUE, comment.char = "")
data.input <- na.omit(data.input)
data.input.levels <- data.input[,c(3:81)]

rownames(data.input.levels) = data.input$ORF
data.input.scale <- scale(data.input.levels)

#Complete Linkage Analysis
pdf("heatmap_output1.pdf", height=50, width=15)
heatmap.2(as.matrix(data.input.scale), hclustfun = function(x) hclust(x, method = "complete"),
          scale = "column", dendrogram = "row", trace = "none", density.info = "none", 
          col = redblue (256), lhei = c(2, 200), lwid = c(0.5, 0.5), key = FALSE, 
          margins = c(5, 8), cexRow = .7, cexCol = .7)
dev.off()

#Average linkage analysis
pdf("heatmap_output2.pdf", height=50, width=15)
heatmap.2(as.matrix(data.input.scale), hclustfun = function(x) hclust(x, method = "average"),
          scale = "column", dendrogram = "row", trace = "none", density.info = "none", 
          col = redblue (256), lhei = c(2, 200), lwid = c(0.5, 0.5), key = FALSE, 
          margins = c(5, 8), cexRow = .7, cexCol = .7)
dev.off()

#Pearson Correlation
correlation <- function(x, ...){as.dist(1-cor(t(x), method="pearson"))}

pdf("heatmap_output3.pdf", height=50, width=15)
heatmap.2(as.matrix(data.input.levels), distfun = correlation, hclustfun = function (x) hclust(x, method = "average"),  
          scale = "row", dendrogram = "row", trace = "none", density.info = "none", 
          col = redblue (256), lhei = c(2, 200), lwid = c(0.5, 0.5), key = FALSE, 
          margins = c(5, 8), cexRow = .7, cexCol = .7)
dev.off()
