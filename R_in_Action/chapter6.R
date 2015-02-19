# Chapter 6 Basic praphs

# 6.1 Bar plots

#6.1.1 simple bar plot

# barplot(height)

library(vcd)


counts <- table(Arthritis$Improved)
counts

opar <- par(pin=c(3, 2), mai=c(1, 1, 1, 1))
barplot(counts,
        main = 'Simple Bar Plot',
        xlab = 'Improvement', ylab = 'Frequency')
par(opar)

barplot(counts,
        main = 'Horizental Bar Plot',
        xlab = 'Frequency', ylab = 'Improvement',
        horiz = TRUE)

plot(Arthritis$Improved, main = 'Simple Bar Plot',
     xlab = 'Improvement', ylab = 'Frequency')

plot(Arthritis$Improved, main = 'Horizental Bar Plot', 
     xlab = 'Frequency', ylab = 'Improvement',
     horiz = TRUE)

attach(mtcars)
cardata <- mtcars[1:5, 1]

barplot(cardata, main='Simple bar plot',
        xlab='Type of cars', ylab='mpg')


cardata <- mtcars[1:5, 1]

plot(cardata, main='Simple bar plot',
        xlab='Type of cars', ylab='mpg')

cardata2 <- mtcars[1:5, 1:4]
barplot(cardata2$mpg, main='Simple bar plot',
        xlab='Type of cars', ylab='mpg')

plot(cardata2$mpg, main='Simple bar plot',
        xlab='Type of cars', ylab='mpg')
# This is not a bar plot. Maybe the variable is not a factor.

# 6.1.2 stacked and grouped bar plot

counts <- table(Arthritis$Improved, Arthritis$Treatment)
counts

barplot(counts,
        main = 'Stacked Bar Plot',
        xlab = 'Treatment', ylab = 'Frequency',
        col = c('red', 'yellow', 'green'),
        legend = row.names(counts))

barplot(counts,
        main = 'Grouped Bar Plot',
        xlab = 'Treatment', ylab = 'Frequency',
        col = c('red', 'yellow', 'green'),
        legend = row.names(counts), beside = TRUE)

attach(mtcars)
str(mtcars)
mymtcars <- mtcars[2:4, 1:6]
mymtcars <- as.matrix(mymtcars)
is.matrix(mymtcars)
barplot(mymtcars, 
        main='Stacked bar plot',
        xlab='x', ylab='y')


# 6.1.3 Mean bar plots

states <- data.frame(state.region, state.x77)
head(states)

means <- aggregate(states$Illiteracy, by=list(state.region),
                  FUN=mean)
means

means <- means[order(means$x), ]

barplot(means$x, names.arg=means$Group.1)
title('Mean Illiteracy Rate')

# install.packages('gplots')

# 6.1.4 Tweaking bar plots

par(mar=c(5, 8, 4, 2))
par(las=2) # direction of labels
counts <- table(Arthritis$Improved)

barplot(counts,
        main = 'Treatment Outcome',
        horiz = TRUE, cex.name = 0.8,
        names.arg = c('No Improvement', 'Some Improvement',
                      'Marked Improvement'))

# 6.1.5 Spinograms

library(vcd)
attach(Arthritis)
head(Arthritis)
counts <- table(Treatment, Improved)
spine(counts, main = 'Spinograme Example')
detach(Arthritis)

6.2 Pie charts

# pie(x, labels)

par(mfrow=c(2,2))
slices <- c(10, 12, 4, 16, 8)
lbls <- c('US', 'UK', 'Australia', 'Germany', 'France')

pie(slices, labels=lbls, main= 'Simple Pie Chart')

pct <- round(slices/sum(slices)*100)
lbls2 <- paste(lbls, ' ', pct, '%', sep='')
pie(slices, labels=lbls2, col=rainbow(length(lbls2)),
    mian='Pie Chart with Percentages')

# library(plotrix)
# pie3D(slices, labels=lbls, explode=0.1, main='3D Pie Chart)

mytable >- table(state.region)
lbls3 <- paste(names(mytable), '\n', mytable, sep='')
pie(mytable, labels=lbls3,
    main='Pie Chart from a Table\n (with sample sizes)')

# library(plotrix)
# slices <- c(10, 12, 4, 16, 8)
# lbls <- c('US', 'UK', 'Australia', 'Germany', 'France')
# fan.plot(slices, labels=lbls, mian='Fan Plot')

# 6.3 histogrames

# hist(x)
# freq=FALSE
# breaks

par(mfrow=c(2, 2))

hist(mtcars$mpg)

hist(mtcars$mpg,
     breaks=12, col='red', xlab='Miles per gallon',
     main='Colored hitogram with 12 bins')

hist(mtcars$mpg, freq=FALSE,
     breaks=12, col='red', xlab='Miles per gallon',
     main='Histogram, rug plot, density curve')
rug(jitter(mtcars$mpg))
lines(density(mtcars$mpg), col='blue', lwd=2)


x <- mtcars$mpg
h <- hist(x, breaks=12, col='red', xlab='Miles per gallon',
     main='Histogram with norm curve and box')
xfit <- seq(min(x), max(x), length=40)
yfit <- dnorm(xfit, mean=mean(x), sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col='blue', lwd=2)
box()

# 6.4 Kernal density plots

# plot(density(x))

par(mfrow=c(2, 1))

d <- density(mtcars$mpg)
plot(d)

d <- density(mtcars$mpg)
plot(d, main='Kernal Density on Miles Per Gallon')

# polygon
polygon(d, col='red', border='blue')
rug(mtcars$mpg, col='brown')

# install.packages('sm')
# sm.density.compare(x, factor)

par(lwd=2)
library(2)
attach(mtcars)

# Creating grouping factors
cy1.f <- factor(cyl, levels = c(4, 6, 8),
                 labels = c('4 cylinders', '6 cylinders',
                            '8 cylinders')) 

# Plot density
sm.density.compare(mpg, cyl, xlab='Miles Per Gallon')
title(Main = 'MPG Distribution by Car Cylinders')

# Adding legend via mouse click
colfill <- c(2: c(1+length(levels(cyl.f))))
legend(locator(1), levels(cyl.f), fill=colfill)

detach(mtcars)


# Box Plots

opar <- par((no.readonly=TRUE))
opar <- par(pin=c(5, 6), mai=c(.5, .5, 1.5, .5))
boxplot(mtcars$mpg, main='Box Plot', ylab='Miles Per Gallon')
par(opar)

boxplot.stats(mtcars$mpg)

# 6.5.1 Using parallel box plots to compare groups

# boxplot(formula, data = dataframe)

boxplot(mpg~cyl, data = mtcars,
        main = 'Car MIleage Data',
        xlab = 'Number of Cylinders',
        ylab = 'Miles Per Gallon')

boxplot(mpg~cyl, data = mtcars,
        notch = TRUE,  # get notched box
        varwidth=TRUE,  # make the boxplot width proportional.
        col = 'red',
        main = 'Car MIleage Data',
        xlab = 'Number of Cylinders',
        ylab = 'Miles Per Gallon')


mtcars$cyl.f <- factor(mtcars$cyl,
                       levels = c(4, 6, 8),
                       labels = c('4', '6', '8'))

mtcars$am.f <- factor(mtcars$am,
                      levels = c(0, 1),
                      labels = c('auto', 'standard'))
boxplot(mpg~cyl.f*am.f, data = mtcars,
        varwidth=TRUE,  # make the boxplot width proportional.
        col = c('gold', 'darkgreen'),
        main = 'MPG Distribution by Auto Type',
        xlab = 'Auto Type')

# 6.5.2 Violin plots

# install.packages('violin')
# violin(x1, x2, ... , names = , col = ' ')

library(violin)
x1 <- mtcars$mpg[mycars$cyl == 4]
x2 <- mtcars$mpg[mycars$cyl == 6]
x3 <- mtcars$mpg[mtcars$cyl == 8]
violin(x1, x2, x3,
       names = c('4 cyl', '6 cyl', '8 cyl'),
       col = 'gold')
title(main = 'Violin Plot of Miles Per Gallon')


# 6.6 Dot plots

# dotchart(x, labels= )

dotchart(mtcars$mpg, labels = row.names(mtcars),
         cex = 0.7, main = 'Gas Mileage for Car models',
         xlab = 'Miles Per Gallon')

x <- mtcars[order(mtcars$mpg), ]
x$cyl <- factor(x$cyl)
x$color[x$cyl == 4] <- 'red'
x$color[x$cyl == 6] <- 'blue'
x$color[x$cyl == 8] <- 'darkgreen'
dotchart(x$mpg,
         labels = row.names(x),
         cex = 0.7,
         groups = x$cyl,
         gcolors = 'black',
         color = x$color,
         pch = 19,
         main = 'Gas Mileage for Car Models\ngrouped by cylinder',
         xlab = 'Miles Per Gallon')

6.7 Summary













































