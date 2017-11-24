# chapter 11 intermidiate graphs

# 11.1 scatter plot

with(mtcars,
     plot(wt, mpg,
          main = 'Basic scatter plot of MPG vs. Weight',
          xlab = 'Car weight (lbs/100)',
          ylab = 'Miles per gallon',
          pch = 19))
# the lowess function increases a smoothed line
lowess(mtcars$wt, mtcars$mpg)

with(mtcars,
     lines(lowess(wt, mpg), col = 'blue', lwd = 2, lty = 2))


with(mtcars,
     abline(lm(mpg~wt), col = 'red', lwd = 2, lty = 1))

library(car)
scatterplot(mpg ~ wt, data = mtcars)
scatterplot(mpg ~ wt|cyl, data = mtcars)

scatterplot(mpg~wt|cyl, data = mtcars, lwd = 2,
            main = 'Scatter plot of mpg vs wt by cylinders',
            xlab = 'Weight of cars (lbs/100)',
            ylab = 'Miles per gallon',
            legend.plot = TRUE,
            id.method = 'identify',
            labels = row.name(mtcars),
            boxplot = 'xy')

# 11.1.1 scatter plot matrices

pairs(~mpg + disp + drat + wt, data = mtcars,
      main = 'Basic scatter plot matrix')

pairs(~mpg + disp + drat + wt, data = mtcars,
      main = 'Basic scatter plot matrix',
      upper.panel = NULL)

library(car)

scatterplotMatrix(~mpg + disp + drat + wt, 
                  data = mtcars)

scatterplotMatrix(~mpg + disp + drat + wt, 
                  data = mtcars, spread = FALSE)

scatterplotMatrix(~mpg + disp + drat + wt, 
                  data = mtcars, spread = FALSE,
                  lty.smooth = 2,
                  main = 'Basic scatter plot matrix')

scatterplotMatrix(~mpg + disp + drat + wt|cyl, 
                  data = mtcars, spread = FALSE,
                  diagonal = 'histogram',
                  main = 'Basic scatter plot matrix')

install.packages('gclus')
library(gclus)
names(mtcars)
cor(mtcars[c('mpg', 'wt', 'disp', 'drat')])
mtdata <- mtcars[c(1, 3, 5, 6)]
mydata.corr <- abs(cor(mtdata))  # ?
mydata.corr
mycolors <- dmat.color(mydata.corr)
mycolors
myorder <- order.single(mydata.corr)
myorder
cpairs(mtdata,
       myorder,
       panel.color = mycolors,
       gap = 0.5,
       main = 'Variables ordered and colored by correlation'
       )

# 11.1.2 high-density scatter plots

matrix(rnorm(10, mean = 0, sd = 0.5), ncol = 2)

set.seed(1234)
n <- 10000
c1 <- matrix(rnorm(n, mean = 0, sd = 0.5), ncol = 2)
c2 <- matrix(rnorm(n, mean = 3, sd = 2), ncol = 2)
mydata <- rbind(c1, c2)
mydata <- as.data.frame(mydata)
names(mydata) <- c('x', 'y')
with(mydata,
     plot(x, y, pch = 19,
          main = 'scatter plot with 10,000 observations'))

set.seed(1234)
n <- 10000
c1 <- matrix(rnorm(n, mean = 0, sd = 0.5), ncol = 2)
c2 <- matrix(rnorm(n, mean = 3, sd = 2), ncol = 2)
mydata <- rbind(c1, c2)
mydata <- as.data.frame(mydata)
names(mydata) <- c('x', 'y')
with(mydata,
     smoothScatter(x, y,
          main = 'scatter plot with 10,000 observations'))

# hexbin()
install.packages('hexbin')
library(hexbin)
with(mydata, {
     bin <- hexbin(x, y, xbins = 50)
     plot(bin)
})

# iplot()
install.packages('IDPmisc')
library(IDPmisc)
with(mydata,
     iplot(x, y))

# 11.1.3 3D scatter plot

# scatterplot3d()

install.packages('scatterplot3d')
library(scatterplot3d)
par('mar')
par(mar = c(1, 1, 1, 1))
with(mtcars,
     scatterplot3d(wt, disp, mpg,
                   main = 'Basic 3D Scatter Plot'))

with(mtcars,
     scatterplot3d(wt, disp, mpg,
                   main = 'Basic 3D Scatter Plot',
                   pch = 19,
                   highlight.3d = T,
                   type = 'h'))

s3dplot <- with(mtcars,
     scatterplot3d(wt, disp, mpg,
                   main = 'Basic 3D Scatter Plot',
                   pch = 19,
                   highlight.3d = T,
                   type = 'h'))

fit <- lm(mpg ~ wt + disp, data = mtcars)
s3dplot$plane3d(fit)

# spining 3d plot
install.packages('rgl')
library(rgl)
with(mtcars,
     plot3d(wt, disp, mpg, col = 'red', size = 5))

library(Rcmdr)
with(mtcars,
     scatter3d(wt, disp, mpg))

# 11.4 bubble plot

# symbols(x, y, circle = radius)

attach(mtcars)
r <- sqrt(disp/pi)
symbols(wt, mpg, circle = r,
        inches = 0.4, fg = 'white',
        bg = 'lightblue',
        main = 'Bubble plot with point size proportational to displacement',
        ylab = 'Miles per gallon',
        xlab = 'Weight of car (lbs/100)')
text(wt, mpg, row.names(mtcars), cex = 0.6)
detach(mtcars)

# 11.2 line charts

opar <- par(no.readonly = TRUE)
par(mfrow = c(1, 2))
t1 <- subset(Orange, Tree == 1)
plot(t1$age, t1$circumference,
     xlab = 'Age (day)',
     ylab = 'Circumference (mm)',
     main = 'Orange Tree 1 Growth')
plot(t1$age, t1$circumference,
     xlab = 'Age (day)',
     ylab = 'Circumference (mm)',
     main = 'Orange Tree 1 Growth',
     type = 'b')
par(opar)

# plot(x, y, type = )
# lines(x, y, type = )

Orange$Tree <- as.numeric(Orange$Tree)
ntrees <- max(Orange$Tree)

# set up plot
xrange <- range(Orange$age)
yrange <- range(Orange$circumference)

plot(xrange, yrange, 
     xlab = 'Age (day)', 
     ylab = 'Circumference (mm)',
     type = 'n')

colors <- rainbow(ntrees)
linetype <- c(1:ntrees)
plotchar <- seq(18, 18 + ntrees, 1)

# add lines
for (i in 1:ntrees){
     tree <- subset(Orange, Tree == i)
     lines(tree$age, tree$circumference,
           type = 'b',
           lwd = 2,
           lty = linetype[i],
           col = colors[i],
           pch = plotchar[i])
}

title('Tree Growth', 'example of line plot')

# add legend

legend(xrange[1], yrange[2],
       1:ntrees,
       cex = 0.8,
       col = colors,
       pch = plotchar,
       lty = linetype,
       title = 'Tree')

# 11.3 correlograms

options(digits = 2)
cor(mtcars)

install.packages('corrgram')
library(corrgram)
corrgram(mtcars, order = T, lower.panel = panel.shade)
corrgram(mtcars, order = TRUE, 
         lower.panel = panel.shade,
         upper.panel = panel.pie,
         text.panel = panel.txt,
         main = 'Correlograms of mtcars intercorrelations')

corrgram(mtcars, order = TRUE, 
         lower.panel = panel.ellipse,
         upper.panel = panel.pts,
         text.panel = panel.txt,
         diag.panel = panel.minmax,
         main = 'Correlograms of mtcars intercorrelations')

# Mosaic plots

ftable(Titanic)
# mosaic(table)
# mosaic(formula, data = )

library(vcd)
mosaic(~ Class + Sex + Age + Survived,
       data = Titanic,
       shade = T, legend = T)












