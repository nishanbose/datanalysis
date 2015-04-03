# Connecting to an sqlite Database
# Load the libraries needed for this
library(DBI)
library(RSQLite)
library(plyr)
library(ggplot2)

# Load the driver needed for this
driver<-dbDriver("SQLite")

# Connect to the database "cars"
connect<-dbConnect(driver, dbname = "vehicles.db")

# Loading information into data frames
carsTable = dbGetQuery(connect, "select * from vehicles")

#Displaying first ten entries
head(carsTable,n=10)

#Displaying summary
summary(carsTable)

#Converting into factors
carsTable$make <- as.factor(carsTable$make)
carsTable$vclass <- as.factor(carsTable$vclass)
carsTable$cylinders <- as.factor(carsTable$cylinders)
carsTable$trany <- as.factor(carsTable$trany)
summary(carsTable)

#Filtering down data
carsTable.ddply <- ddply(carsTable, c("vclass"), transform, vclass.size = length(vclass))
carsTable.subset <- subset(carsTable.ddply, vclass.size > 40)
carsTable.subset <- subset(carsTable.subset, select = -vclass.size)
summary(carsTable.subset)

vclass.unique <- unique(carsTable.subset$vclass)

for (item in vclass.unique) {
  vclass.subset <- subset(carsTable.subset, vclass==item)
  
  year.data <- ddply(vclass.subset, c("make","year"), summarise, avg.data = mean(combo08))
  year.plot <- ggplot(year.data, aes(year, avg.data)) + ggtitle(item) + xlab("Year") + ylab("Mean Combined MPG") + guides(col=guide_legend(ncol=2)) + geom_line(aes(colour = make))
  print(year.plot)
  
  make.data <- ddply(vclass.subset, c("make"), summarise, avg.data = mean(combo08))
  make.plot <- qplot(reorder(make, avg.data, function(x) -x), y = avg.data, data = make.data, geom="bar", stat = "identity", alpha = I(0.5), main=(item)) + xlab("Make") + ylab("Mean Combined MPG in All Years") + theme(axis.text.x=element_text(angle=90,hjust=1,vjust=1));
  print(make.plot)
}
