## chapeter 9 Analysis of variance

install.packages('gplots')
install.packages('HH')
install.packages('rrcov')
install.packages('mvoutlier')
install.packages('multcomp')

# 9.1 A crash course on terminology

# 9.2 Fitting AVOVA models

# 9.2.1 the aov() function

# 9.2.2 the order of fomular terms

library(multcomp)
library(dplyr)

head(cholesterol)

with(cholesterol, table(trt))
with(cholesterol, aggregate(response, by = list(trt), FUN = mean))

with(cholesterol, aggregate(response, by = list(trt), FUN = sd))

with(cholesterol, fit <- aov(response ~ trt))
     
summary(fit)
















