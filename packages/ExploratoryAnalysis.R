
# Ploting system

## Lattice plot

library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, 
       data = state, 
       layout = c(4, 1))

## ggplot2 plot

library(ggplot2)
with(mtcars, 
     qplot(disp, hwy, data = mpg))



# Plotting base

## histogram

library(datasets)
hist(airquality$Ozone)

# scatterplot

with(airquality, plot(Wind, Ozone))
title(main = 'Ozone and Wind in New York City')

# boxplot

airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, 
        xlab = 'Month', ylab = 'Ozone(ppb)')

# base plot with annotation

with(airquality, 
     plot(Wind, Ozone, 
          main = 'Ozone and Wind in New York City'))

with(subset(airquality, Month == 5),
     points(Wind, Ozone, col = 'blue'))


with(airquality,
     plot(Wind, Ozone,
          main = 'Ozone and Wind in New York City', 
          type = 'n'))
with(subset(airquality, Month == 5),
     points(Wind, Ozone, col = 'blue'))

with(subset(airquality, Month != 5),
     points(Wind, Ozone, col = 'red'))

legend('topright', pch = 1, col = c('blue', 'red'),
       legend = c('May', 'Other Months'))

#  base plot with regression line

with(airquality, 
     plot(Wind, Ozone, 
          main = 'Ozone and Wind in New York City',
          pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2, col = 'blue')

# multiple base plot

opar <- par(no.readonly = TRUE)
opar <- par(mfrow = c(1, 2))
with(airquality, {
     plot(Wind, Ozone, main = 'Wind and Ozone in NYC')
     plot(Solar.R, Ozone, main = 'Ozone and Solar Radiation')
})
par(opar)


opar <- par(no.readonly = TRUE)
opar <- par(mfrow = c(1, 3), 
            mar = c(4, 4, 2, 1),
            oma = c(0, 0, 2, 0)) # the outer margin size
with(airquality, {
     plot(Wind, Ozone, main = 'Wind and Ozone in NYC')
     plot(Solar.R, Ozone, main = 'Ozone and Solar Radiation')
     plot(Temp, Ozone, main = 'Ozone and Temp in NYC')
     mtext('Ozone and Weather in NYC',outer = T)
})
# mtext: adding arbotrary text to the margins (inner or outer)

par(opar)

# Ploting and color in R

## RColorBrewer and colorRampPalette

library(RColorBrewer)
cols <- brewer.pal(3, 'BuGn')
cols

par(no.readonly = TRUE)
pal <- colorRampPalette(cols)
image(volcano, col = pal(20))

## The smoothScatter function

x <- rnorm(10000)
y <- rnorm(10000)
smoothScatter(x, y)

## Transparancy

plot(x, y, pch=19)
plot(x, y, col = rgb(0, 0, 0, 0.2), pch = 19)

# Ploting math

plot(0, 0, main = expression(theta == 0),
     ylab = expression(hat(gamma) == 0),
     xlab = expression(sum(x[i] * y[i],
                           i == 1, n)))

x <- rnorm(100)
hist(x,
     xlab = expression('The mean (' * bar(x) * ') is ' *
                            sum(x[i]/n, i==1, n)))


# The Lattice ploting system

## lattice function

## xyplot 
## bwplot
## histogram
## stripplot
## dotplot
## spolm
## levelplot, contourplot

## xyplot(y ~ x | f * g, data)

## simple lattice plot
library(lattice)
library(datasets)
xyplot(Ozone ~ Wind, data = airquality)

airquality <- transform(airquality, Month = factor(Month))
# layout(m, n), m cols and n rows.
xyplot(Ozone ~ Wind | Month,
       data = airquality,
       layout = c(5, 1))

p <- xyplot(Ozone ~ Wind, data = airquality)
print (p)

## lattice panel functions

set.seed(1234)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c('Group 1', 'Group 2'))
xyplot(y ~ x | f, layout = c(2, 1))

xyplot(y ~ x | f, panel = function(x, y, ...){
     panel.xyplot(x, y, ...)  # call the default function
     panel.abline(h = median(y), lty = 2)  # add a horiz line
})

xyplot(y ~ x | f, panel = function(x, y, ...){
     panel.xyplot(x, y, ...)  # call the default function
     panel.lmline(x, y, col = 2)  # add a regression line
})

# Graphics devices

pdf(file = 'myplot.pdf')
library(datasets)
head(faithful)
with(faithful, plot(eruptions, waiting))
title(main = 'Old faithful geyser data')
dev.off()

## dev.copy()
## dev.copy2pdf()

library(datasets)
with(faithful, plot(eruptions, waiting))
title(main = 'Old faithful geyser data')
dev.copy(png, file = 'geyserplot.png')
dev.off()


# Principal components analysis and 
# Singular value decomposition

## matrix data
set.seed(1234)
par(mar = rep (0.2, 4))
dataMatrix <- matrix(rnorm(400), nrow = 40)
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix): 1])

## cluster the data

par(mar = rep(0.2, 4))
heatmap(dataMatrix)

set.seed(33637)
for (i in 1:40){
     # flip a coin
     coinflip <- rbinom(1, size = 1, prob = 0.5)
     # if coin is head, add a pattern to that row
     if (coinflip){
          dataMatrix[i, ] <- dataMatrix[i, ] +
               rep(c(0, 3), each = 5)
     }
}
par(mar = rep(0.5, 4))
image(1:10, 1:40,
      t(dataMatrix)[, nrow(dataMatrix): 1])

set.seed(33637)
# flip a coin
coinflip <- rbinom(1, size = 1, prob = 0.5)
for (i in 1:40){
     # if coin is head, add a pattern to that row
     if (coinflip == 1){
          dataMatrix[i, ] <- dataMatrix[i, ] +
               rep(c(0, 3), each = 5)
     }
}
par(mar = rep(0.5, 4))
image(1:10, 1:40,
      t(dataMatrix)[, nrow(dataMatrix): 1])

set.seed(33637)
# flip a coin
coinflip <- rbinom(1, size = 1, prob = 0.5)
for (i in 1:40){
     # if coin is head, add a pattern to that row
     if (coinflip == 1){
          dataMatrix[i, ] <- dataMatrix[i, ] +
               rep(c(0, 3), each = 5)
     }
}

par (mar = rep(0.5, 4))
heatmap(dataMatrix)

## patterns in rows and columns

par(no.readonly = TRUE)
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order, ]
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered): 1])
plot(rowMeans(dataMatrixOrdered),
     40:1,
     xlab = 'Row Meam',
     ylab = 'Row',
     pch = 19)
plot(colMeans(dataMatrixOrdered),
     xlab = 'Column',
     ylab = 'Col Means',
     pch = 19)






# Hierarchical clustering

set.seed(1234)
par(mar = c(3, 3, 3, 3))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = 'blue', pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1: 12))

dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
plot(hClustering)

dataFrame <- data.frame(x = x, y = y)
set.seed(123)
datamatrix <- as.matrix(dataFrame)[sample(1:12), ]
heatmap(datamatrix)






























