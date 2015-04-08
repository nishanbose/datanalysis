#Loading Libraries
library("ggplot2")
library("hexbin")

#Loading data into variable
data.input <- read.table(file="star_sentimentscore.txt", fill=TRUE, sep="\t", quote="", dec = ".", comment.char = "")

#Scatterplot for average stars and average sentiment scores with linear regression
ggplot(data.input, aes(x=V1,y=V2)) + geom_point(shape=1) + geom_smooth(method=lm, se=FALSE) + xlab("Avg Star Rating") + ylab("Avg Sentiment Rating") + ggtitle("Scatterplot with regression line")

#Scatterplot with hex binning
ggplot(data.input, aes(x=V1,y=V2)) + stat_binhex() + xlab("Avg Star Rating") + ylab("Avg Sentiment Rating") + ggtitle("Scatterplot with hex binning")

# Pearson correlation
p.cor <- cor(x=data.input$V1, y=data.input$V2, method=c("pearson"))
cat(("The pearson correlation is"), p.cor)
