
#RSQLite examples, 2/10/2015

#load necessary libraries
library(sqldf)
library(RSQLite)
library(DBI)


########################################## EXAMPLE 1 - basic functions in sqldf

# shows built in data frames
data(iris) 
View(iris)

# select desired data
sqldf("select * from iris limit 5")
sqldf("select count(*) from iris")
sqldf("select Species, count(*) from iris group by Species")

# create a data frame
DF <- data.frame(a = 1:5, b = letters[1:5])

#select desired data
sqldf("select * from DF")
sqldf("select avg(a) avg, variance(a) var from DF")
sqldf('select * from iris order by "Sepal.Length" desc limit 3')
sqldf("select avg(demand) mean, variance(demand) var from BOD")

#######################EXAMPLE 2 - creating db tables in R; necessary data provided in email

# Create an ephemeral in-memory RSQLite database
con <- dbConnect(RSQLite::SQLite(), ":memory:")
# Copy in the buit-in mtcars data frame
dbWriteTable(con, "mtcars", mtcars, row.names = FALSE)
  #> [1] TRUE

# Fetch all results from a query:
res <- dbSendQuery(con, "SELECT * FROM mtcars WHERE cyl = 4 AND mpg < 23")
dbFetch(res)
#>    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> 1 22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
#> 2 22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
#> 3 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
#> 4 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
dbClearResult(res)
#> [1] TRUE

# Or fetch them a chunk at a time
res <- dbSendQuery(con, "SELECT * FROM mtcars WHERE cyl = 4")
while(!dbHasCompleted(res)){
  chunk <- dbFetch(res, n = 10)
  print(nrow(chunk))
}
#> [1] 10
#> [1] 1
dbClearResult(res)
#> [1] TRUE

# Good practice to disconnect from the database when you're done
dbDisconnect(con)
#> [1] TRUE



################################

#Create database 'db', two ways

db <- dbConnect(SQLite(), dbname="Test.sqlite")

sqldf("attach 'Test1.sqlite' as new")

#create table in db

dbSendQuery(conn = db,
            "CREATE TABLE School
       (SchID INTEGER,
        Location TEXT,
        Authority TEXT,
        SchSize TEXT)")

#populate

dbSendQuery(conn = db,
            "INSERT INTO School
         VALUES (1, 'urban', 'state', 'medium')")
dbSendQuery(conn = db,
            "INSERT INTO School
         VALUES (2, 'urban', 'independent', 'large')")
dbSendQuery(conn = db,
            "INSERT INTO School
         VALUES (3, 'rural', 'state', 'small')")

#db navigation

dbListTables(db)              # The tables in the database
dbListFields(db, "School")    # The columns in a table
dbReadTable(db, "School")     # The data in a table

dbRemoveTable(db, "School")     # Remove the School table.

#populate by .csv
dbWriteTable(conn = db, name = "Student", value = "student.csv",
             row.names = FALSE, header = TRUE)
dbWriteTable(conn = db, name = "Class", value = "class.csv",
             row.names = FALSE, header = TRUE)
dbWriteTable(conn = db, name = "School", value = "school.csv",
             row.names = FALSE, header = TRUE)

#db navigation

dbListTables(db)                   # The tables in the database
dbListFields(db, "School")         # The columns in a table
dbReadTable(db, "School")          # The data in a table

#populate by excel workbook

dbRemoveTable(db, "School")        # Remove the tables
dbRemoveTable(db, "Class")
dbRemoveTable(db, "Student")

# Import the three sheets of the Excel workbook
wb <- XLConnect::loadWorkbook("Test.xlsx")
Tables <- XLConnectJars::readWorksheet(wb, sheet = getSheets(wb)) #can't find XLConnect?? problem installing due to incompatible r and java 32 v 64 bit versions??


#######################EXAMPLE 3 - equivalent results from functions in R and sqldf

# These examples show how to run a variety of data frame manipulations
# in R without SQL and then again with SQL
#
# head
a1r <- head(warpbreaks)
a1s <- sqldf("select * from warpbreaks limit 6")
identical(a1r, a1s)

# subset
a2r <- subset(CO2, grepl("^Qn", Plant))
a2s <- sqldf("select * from CO2 where Plant like 'Qn%'")
all.equal(as.data.frame(a2r), a2s)

data(farms, package = "MASS")
a3r <- subset(farms, Manag %in% c("BF", "HF"))
a3s <- sqldf("select * from farms where Manag in ('BF', 'HF')")
row.names(a3r) <- NULL
identical(a3r, a3s)

a4r <- subset(warpbreaks, breaks >= 20 & breaks <= 30)
a4s <- sqldf("select * from warpbreaks where breaks between 20 and 30",
             row.names = TRUE)
identical(a4r, a4s)

a5r <- subset(farms, Mois == 'M1')
a5s <- sqldf("select * from farms where Mois = 'M1'", row.names = TRUE)
identical(a5r, a5s)

# aggregate - avg conc and uptake by Plant and Type
a8r <- aggregate(iris[1:2], iris[5], mean)
a8s <- sqldf('select Species, avg("Sepal.Length") `Sepal.Length`,
             avg("Sepal.Width") `Sepal.Width` from iris group by Species')
all.equal(a8r, a8s)

# by - avg conc and total uptake by Plant and Type
a9r <- do.call(rbind, by(iris, iris[5], function(x) with(x,
                                                         data.frame(Species = Species[1],
                                                                    mean.Sepal.Length = mean(Sepal.Length),
                                                                    mean.Sepal.Width = mean(Sepal.Width),
                                                                    mean.Sepal.ratio = mean(Sepal.Length/Sepal.Width)))))
row.names(a9r) <- NULL
a9s <- sqldf('select Species, avg("Sepal.Length") `mean.Sepal.Length`,
             avg("Sepal.Width") `mean.Sepal.Width`,
             avg("Sepal.Length"/"Sepal.Width") `mean.Sepal.ratio` from iris
             group by Species')
all.equal(a9r, a9s)

