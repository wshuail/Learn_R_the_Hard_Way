
# ch07 OO filed guide

# 7.1 base types
f <- function(){}
typeof(f)
is.function(f)

typeof(sum)
is.primitive(sum)

# 7.2 S3

# 7.2.1 recognising objects, generic functions and method
library(pryr)
df <- data.frame(x = 1: 10, y = letters[1: 10])
otype(df)
otype(df$x)
otype(df$y)

mean
ftype(mean)
