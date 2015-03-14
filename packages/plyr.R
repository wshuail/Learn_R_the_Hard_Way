# plyr

# arrange(df, ...)

# sort mtcars data by cylinder and displacement
mtcars[with(mtcars, order(cyl, disp)), ]
# Same result using arrange: no need to use with(), as the context is implicit
# NOTE: plyr functions do NOT preserve row.names
arrange(mtcars, cyl, disp)
# Let's keep the row.names in this example
myCars = cbind(vehicle=row.names(mtcars), mtcars)
arrange(myCars, cyl, disp)
# Sort with displacement in descending order
arrange(myCars, cyl, desc(disp))


# mutate(.data, ...)

# Examples from transform
head(airquality)
mutate(airquality, Ozone = -Ozone)
mutate(airquality, new = -Ozone, Temp = (Temp - 32) / 1.8)

# Things transform can't do
mutate(airquality, Temp = (Temp - 32) / 1.8, OzT = Ozone / Temp)

# mutate is rather faster than transform
system.time(transform(baseball, avg_ab = ab / g))
system.time(mutate(baseball, avg_ab = ab / g))


# summarise(.data, ...)

# Let's extract the number of teams and total period of time
# covered by the baseball dataframe
summarise(baseball,
          duration = max(year) - min(year),
          nteams = length(unique(team)))
# Combine with ddply to do that for each separate id
sum <- ddply(baseball, "id", summarise,
      duration = max(year) - min(year),
      nteams = length(unique(team)))
head(sum)


# join(x, y, by = NULL, type = "left", match = "all")

first <- ddply(baseball, "id", summarise, first = min(year))
system.time(b2 <- merge(baseball, first, by = "id", all.x = TRUE))
system.time(b3 <- join(baseball, first, by = "id"))

b2 <- arrange(b2, id, year, stint)
b3 <- arrange(b3, id, year, stint)
stopifnot(all.equal(b2, b3))


# match_df(x, y, on = NULL)

# count the occurrences of each id in the baseball dataframe, 
# then get the subset with a freq >25
longterm <- subset(count(baseball, "id"), freq > 25)
longterm
dim(longterm)
str(baseball)
# longterm
#             id freq
# 30   ansonca01   27
# 48   baineha01   27
# ...
# Select only rows from these longterm players from the
# baseball dataframe (match would default to match on 
# shared column names, but here was explicitly set "id")
bb_longterm <- match_df(baseball, longterm, on="id")
bb_longterm[1:5,]
dim(bb_longterm)


# colwise(.fun, .cols = true, ...)
# catcolwise(.fun, ...)
# numcolwise(.fun, ...)

# Count number of missing values
nmissing <- function(x) sum(is.na(x))

# Apply to every column in a data frame
colwise(nmissing)(baseball)
# This syntax looks a little different.  It is shorthand for the
# the following:
f <- colwise(nmissing)
f(baseball)

# This is particularly useful in conjunction with d*ply
ddply(baseball, .(year), colwise(nmissing))

# To operate only on specified columns, supply them as the 
# second argument.  Many different forms are accepted.
ddply(baseball, .(year), colwise(nmissing, .(sb, cs, so)))
ddply(baseball, .(year), colwise(nmissing, c("sb", "cs", "so")))
ddply(baseball, .(year), colwise(nmissing, ~ sb + cs + so))

# Alternatively, you can specify a boolean function that 
# determines whether or not a column should be included
ddply(baseball, .(year), colwise(nmissing, is.character))
ddply(baseball, .(year), colwise(nmissing, is.numeric))
ddply(baseball, .(year), colwise(nmissing, is.discrete))

# These last two cases are particularly common, so some 
# shortcuts are provided:
ddply(baseball, .(year), numcolwise(nmissing))
ddply(baseball, .(year), catcolwise(nmissing))

# You can supply additional arguments to either colwise, 
#or the function it generates:
numcolwise(mean)(baseball, na.rm = TRUE)
numcolwise(mean, na.rm = TRUE)(baseball)


# rename(x, replace, warn_missing = TRUE)
x <- c("a" = 1, "b" = 2, d = 3, 4)
# Rename column d to "c", updating the variable "x" with
# the result
x <- rename(x, replace=c("d" = "c"))
x
# Rename column "disp" to "displacement"
rename(mtcars, c("disp" = "displacement"))


# round_any(x, accuracy, f = round)
round_any(135, 10)
round_any(135, 100)
round_any(135, 25)
round_any(135, 10, floor)
round_any(135, 100, floor)
round_any(135, 25, floor)
round_any(135, 10, ceiling)
round_any(135, 100, ceiling)
round_any(135, 25, ceiling)

round_any(Sys.time() + 1:10, 5)
round_any(Sys.time() + 1:10, 5, floor)
round_any(Sys.time(), 3600)


# count(df, vars = NULL, wt_var = NULL)
# Count of each value of "id" in the first 100 cases
count(baseball[1:100,], vars = "id")
# Count of ids, weighted by their "g" loading
count(baseball[1:100,], vars = "id", wt_var = "g")
count(baseball, "id", "ab")
count(baseball, "lg")
# How many stints do players do?
count(baseball, "stint")
# Count of times each player appeared in each of the years they played
count(baseball[1:100,], c("id", "year"))
# Count of counts
count(count(baseball[1:100,], c("id", "year")), "id", "freq")
count(count(baseball, c("id", "year")), "freq")


# summarize
?summarize
summarise(.data, ...)
# Let's extract the number of teams and total period of time
# covered by the baseball dataframe
head(baseball)

summarise(baseball,
          duration = max(year) - min(year),
          nteams = length(unique(team)))
# Combine with ddply to do that for each separate id
ddply(baseball, "id", summarise,
      duration = max(year) - min(year),
      nteams = length(unique(team)))


# ddply

library(plyr)
?ddply
# ddply(.data, .variables, .fun = NULL, ..., 
# .progress = "none", .inform = FALSE, .drop = TRUE, 
# .parallel = FALSE, .paropts = NULL)

# ddply(.data, .variables, .fun = NULL, ..., .progress = "none",
#       .inform = FALSE, .drop = TRUE, .parallel = FALSE, 
#       .paropts = NULL)

# Summarize a dataset by two variables
require(plyr)
dfx <- data.frame(
     group = c(rep('A', 8), rep('B', 15), rep('C', 6)),
     sex = sample(c("M", "F"), size = 29, replace = TRUE),
     age = runif(n = 29, min = 18, max = 54)
)

dfx

# Note the use of the '.' function to allow
# group and sex to be used without quoting
mean = round(mean(age), 2)
mean
sd = round(sd(age), 2)
sd

ddply(dfx, .(group, sex), summarize,
      mean = round(mean(age), 2),
      sd = round(sd(age), 2))

# An example using a formula for .variables
ddply(baseball[1:100,], ~ year, nrow)
# Applying two functions; nrow and ncol
ddply(baseball, .(lg), c("nrow", "ncol"))

# Calculate mean runs batted in for each year
rbi <- ddply(baseball, .(year), summarise,
             mean_rbi = mean(rbi, na.rm = TRUE))
# Plot a line chart of the result
plot(mean_rbi ~ year, type = "l", data = rbi)

# make new variable career_year based on the
# start year for each player (id)
base2 <- ddply(baseball, .(id), mutate,
               career_year = year - min(year) + 1
)














