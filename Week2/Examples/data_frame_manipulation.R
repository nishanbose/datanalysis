# Code modified from http://www.ats.ucla.edu/stat/r/faq/subset_R.htm
# and http://www.statmethods.net/index.html

# Subsetting data

x <- matrix(rnorm(30, 1), ncol=5)
y <- c(1, seq(5))

#combining x and y into one matrix
x <- cbind(x, y)

#turning the matrix into a data frame
x.df <- data.frame(x)
print(x.df)
print(names(x.df))

# Selecting a subset of columns
x.sub <- x.df[c("V1", "y")]

#subsetting rows using the subset function
x.sub <- subset(x.df, y > 2)
print(x.sub)

#with multiple conditional statements
x.sub1 <- subset(x.df, y > 2 & V1 > .6)
print(x.sub1)

#subsetting both rows and columns 
x.sub2 <- subset(x.df, y > 2 & V2 > .4, select=c(V1, V4))
print(x.sub2)

x.sub3 <- subset(x.df, y > 3, select= V2:V5)
print(x.sub3)

#subsetting rows using indices
x.sub4 <- x.df[x.df$y == 1, ]
print(x.sub4)

#subsetting row using indices
#selecting on more than one value
#See http://cran.r-project.org/doc/manuals/R-lang.html for a list of R opeartors
x.sub5 <- x.df[x.df$y %in% c(1,4), ]
print(x.sub5)

#subsetting columns using indices
x.sub6 <- x.df[ ,1:2]
print(x.sub6)

x.sub7 <- x.df[ , c(1, 3, 5)]
print(x.sub7)

#subsetting both rows and columns using indices
x.sub8 <- x.df[c(1, 3), 3:6]
print(x.sub8)

# Sorting data
# First take a look at the first couple of rows in the mtcars data
head(mtcars)

# sorting examples using the mtcars dataset
attach(mtcars)

# sort by mpg
newdata <- mtcars[order(mpg),] 

# sort by mpg and cyl
newdata <- mtcars[order(mpg, cyl),]

#sort by mpg (ascending) and cyl (descending)
newdata <- mtcars[order(mpg, -cyl),] 

detach(mtcars)

# aggregate data frame mtcars by cyl and vs, returning means
# for numeric variables
attach(mtcars)
aggdata <-aggregate(mtcars, by=list(cyl,vs), 
                    FUN=mean, na.rm=TRUE)
print(aggdata)
detach(mtcars)

# Merging data frames 
# http://stat.ethz.ch/R-manual/R-patched/library/base/html/merge.html

## use character columns of names to get sensible sort order
authors <- data.frame(
  surname = I(c("Tukey", "Venables", "Tierney", "Ripley", "McNeil")),
  nationality = c("US", "Australia", "US", "UK", "Australia"),
  deceased = c("yes", rep("no", 4)))
books <- data.frame(
  name = I(c("Tukey", "Venables", "Tierney",
             "Ripley", "Ripley", "McNeil", "R Core")),
  title = c("Exploratory Data Analysis",
            "Modern Applied Statistics ...",
            "LISP-STAT",
            "Spatial Statistics", "Stochastic Simulation",
            "Interactive Data Analysis",
            "An Introduction to R"),
  other.author = c(NA, "Ripley", NA, NA, NA, NA,
                   "Venables & Smith"))

(m1 <- merge(authors, books, by.x = "surname", by.y = "name"))
(m2 <- merge(books, authors, by.x = "name", by.y = "surname"))
stopifnot(as.character(m1[, 1]) == as.character(m2[, 1]),
          all.equal(m1[, -1], m2[, -1][ names(m1)[-1] ]),
          dim(merge(m1, m2, by = integer(0))) == c(36, 10))

## "R core" is missing from authors and appears only here :
merge(authors, books, by.x = "surname", by.y = "name", all = TRUE)

## example of using 'incomparables'
x <- data.frame(k1 = c(NA,NA,3,4,5), k2 = c(1,NA,NA,4,5), data = 1:5)
y <- data.frame(k1 = c(NA,2,NA,4,5), k2 = c(NA,NA,3,4,5), data = 1:5)
merge(x, y, by = c("k1","k2")) # NA's match
merge(x, y, by = c("k1","k2"), incomparables = NA)
merge(x, y, by = "k1") # NA's match, so 6 rows
merge(x, y, by = "k2", incomparables = NA) # 2 rows


