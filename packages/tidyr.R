# tidyr

library(tidyr)
?expand
head(mtcars)
expand(mtcars, vs, cyl)
expand(mtcars, cyl, mpg = seq_range(mpg, 2))
expand(mtcars, cyl, mpg = seq_range(mpg, 5))

?seq_range
seq_range(1:100, 5)

df <- data.frame(a = c(1, 2, 5), b = c(3, 5, 3), c = c(1, 2, 3))
expand(df)
expand(df, a, b)
expand(df, a, c)
expand(df, b, c)

?extract
# extract(data, col, into, regex = "([[:alnum:]]+)", remove = TRUE,
# convert = FALSE, ...)

library(dplyr)
df <- data.frame(x = c("a.b", "a.d", "b.c"))
df
extract(x, "A")
df %>% extract(x, "A")
df %>% extract(x, c("A", "B"), "([[:alnum:]]+)\\.([[:alnum:]]+)")

# extract_numeric(x)

extract_numeric("$1,200.34")
extract_numeric("-2%")
# The heuristic is not perfect - it won't fail for things that
# clearly aren't numbers
extract_numeric("-2-2")
extract_numeric("12abc34")

# gather() takes multiple columns, and gathers them into 
# key-value pairs: it makes "wide" data longer.

# gather(data, key, value, ..., na.rm = FALSE, convert = FALSE)

library(dplyr)

messy <- data.frame(
        name = c("Wilbur", "Petunia", "Gregory"),
        a = c(67, 80, 64),
        b = c(56, 90, 50)
)
messy
messy %>%
        gather(drug, heartrate, a:b)

# From http://stackoverflow.com/questions/1181060
stocks <- data.frame(
        time = as.Date('2009-01-01') + 0:9,
        X = rnorm(10, 0, 1),
        Y = rnorm(10, 0, 2),
        Z = rnorm(10, 0, 4)
)
head(stocks)

gather(stocks, stock, price, -time)
stocks %>% gather(stock, price, -time)

head(mtcars)
mtcars_1 <- mtcars %>% gather(mtcars, vs, -am)
mtcars_2 <- melt(mtcars, id = 'am')
identical(mtcars_1, mtcars_2)


# Sometimes two variables are clumped together in one column. 
# separate() allows you to tease them apart (extract() works 
# similarly but uses regexp groups instead of a splitting pattern 
# or position).

# separate(data, col, into, sep = "[^[:alnum:]]+", remove = TRUE,
# convert = FALSE, extra = "error", ...)

set.seed(10)
messy <- data.frame(
        id = 1:4,
        trt = sample(rep(c('control', 'treatment'), each = 2)),
        work.T1 = runif(4),
        home.T1 = runif(4),
        work.T2 = runif(4),
        home.T2 = runif(4)
)
messy

tidier <- messy %>% gather(key, time, -id, -trt)
tidier

tidy <- tidier %>% separate(variable, 
                            into = c('location', 'time'),
                            sep = '\\.')
tidy %>% head(8)



library(dplyr)
df <- data.frame(x = c("a.b", "a.d", "b.c"))
df %>% separate(x, c("A", "B"))
# If every row doesn't split into the same number of pieces, use
# the extra argument to control what happens
df <- data.frame(x = c("a", "a b", "a b c", NA))
df %>% separate(x, c("a", "b"), extra = "merge")
df %>% separate(x, c("a", "b"), extra = "drop")
# If only want to split specified number of times use 
# extra = "merge"
df <- data.frame(x = c("x: 123", "y: error: 7"))
df
df %>% separate(x, c("key", "value"), ": ", extra = "merge")

# seq_range(x, n)
seq_range(1:100, 5)

# spread(data, key, value, fill = NA, convert = FALSE, drop = TRUE)
library(dplyr)
stocks <- data.frame(
        time = as.Date('2009-01-01') + 0:9,
        X = rnorm(10, 0, 1),
        Y = rnorm(10, 0, 2),
        Z = rnorm(10, 0, 4)
)
stocksm <- stocks %>% gather(stock, price, -time)
stocksm
stocksm %>% spread(stock, price)
stocksm %>% spread(time, price)
# Spread and gather are complements
df <- data.frame(x = c("a", "b"), y = c(3, 4), z = c(5, 6))
df %>% spread(x, y) %>% gather(x, y, a:b, na.rm = TRUE)


# spread_(data, key_col, value_col, fill = NA, convert = FALSE, 
# drop = TRUE)

unite(data, col, ..., sep = "_", remove = TRUE)

library(dplyr)
unite_(mtcars, "vs_am", c("vs","am"))
# Separate is the complement of unite

unite(mtcars, vs_am, vs, am)

mtcars %>%
        unite(vs_am, vs, am) %>%
        separate(vs_am, c("vs", "am"))

# unnest(data, col = NULL)

library(dplyr)
df <- data.frame(
        x = 1:3,
        y = c("a", "d,e,f", "g,h"),
        stringsAsFactors = FALSE
)
df

y = strsplit(df$y, ",")
y

df %>%
        transform(y = strsplit(y, ",")) %>%
        unnest(y)
# You can also unnest lists
my_list <- lapply(split(subset(iris, select = -Species), 
                        iris$Species), "[", 1:2, )
my_list
unnest(my_list)
unnest(my_list, Species)

# unnest_(data, col)

