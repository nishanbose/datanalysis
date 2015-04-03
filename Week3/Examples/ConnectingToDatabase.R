# Connecting to an sqlite Database
# Load the libraries needed for this
library(DBI)
library(RSQLite)
library(ggplot2)

# Load the driver needed for this
driver<-dbDriver("SQLite")

# Connect to the database "cars"
connect<-dbConnect(driver, dbname = "carsDatabase.db")

# Run a query and get the results as a data.frame
carsTable = dbGetQuery(connect, "select * from cars")

# Plot using qplot
qplot(Name, Price, data = carsTable)

#Save output as pdf
ggsave(filename = "carsPlot.pdf") 