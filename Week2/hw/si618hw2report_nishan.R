library(ggplot2)
library(plyr)

data.input <- read.table("businessdata.tsv", header = TRUE, sep = "\t", quote = "\"", dec = ".", fill = TRUE, comment.char = "")
data.input <- na.omit(data.input)
head(data.input,n=10)

#star ratings count
qplot(stars, data=data.input, geom="histogram", fill=state, binwidth=0.5, facets=.~state, alpha = I(1/2), margins = 2, main="Histograms of Star Ratings")

#star ratings density 
qplot(stars, y = ..density.., data=data.input, geom="histogram", fill=state, binwidth=0.5, margins = 2, facets=.~state, alpha = I(1/2), main="Histograms of Star Ratings")

#review_count count
qplot(review_count, data=data.input, alpha=I(0.5), geom="histogram", xlab="Review Counts", main="Histograms of Review Counts") + ylim(0,12000)

#review_count density
data.sub <- subset(data.input, review_count <= 500)
qplot(review_count, data=data.sub, color=I("black"), fill=I("grey"), geom="density", xlab="Review Counts", main="Histograms of Review Counts(Filtered)") + ylim(0.00,0.15)

#Box plot of star ratings
qplot(state, stars, data=data.input, geom="boxplot", fill=state, color=state, binwidth=0.5, alpha=I(0.5), ylab="Stars", main="Star Ratings by State")

#Jittered Plot of Star Ratings by States
qplot(state, stars, data=data.input, geom="jitter", fill=state, color=state, binwidth=0.5, alpha=I(0.5), ylab="Stars", main="Star Ratings by State")

#Bar Chart of Number of Businesses by State
qplot(reorder(state, state, function(x) -length(x)), data=data.input, geom="histogram", FUN='sum', alpha=I(0.7))

#Jittered Scatterplot of Stars and Review Counts
qplot(stars, review_count, data=data.input, geom="jitter", fill=state, color=state, binwidth=0.5, alpha=I(0.5))

#Slice and Dice Data with plyr
#Subsetting Data
data.sub <- ddply(data.input, c("main_category","city"), transform, rank = rank(-stars, ties.method = "first"))
top.five <- subset(data.sub, rank<=5 & main_category == "Chinese")
top.five <- subset(top.five, select = c(2, 1, 7))
top.rank <- top.five[order(top.five$city, top.five$rank),]
top.rank

#Summarize Data
data.summary <- aggregate(list(mean_reviews=data.input$review_count), by=list(state = data.input$state), mean)
qplot(reorder(state, mean_reviews, function(x)-x), y=data.summary$mean_reviews, data=data.summary, alpha=I(0.7), geom="histogram", stat="identity", ylab="Mean Review Counts")
