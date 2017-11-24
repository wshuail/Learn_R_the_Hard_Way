# Geting started with graphs

# 3.1 Working with graphs

attach(mtcars)
plot(wt, mpg)
abline(lm(mpg~wt))
title('Regression of MPG on Weight')
detach(mtcars)

pdf('mygraph.pdf')
attach(mtcars)
plot(wt, mpg)
abline(lm(mpg~wt))
title('Regression of MPG on Weight')
detach(mtcars)
dev.off()
# seems this not work

# creat more than one graph
# dev.new()
# statements to create graph 1
# dev.new()
# statements to create graph 2
# etc.

# dev.new(), dev.next(), dev.prev(), dev.set(), dev.off()


# 3.2 A simple example

dose <- c(20, 30, 40, 50, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)
# plot(x, y, type='.')
plot(dose, drugA, type='b')

# 3.3 Graphical parameters

# par()
# par(optionname=value, optionname=value, ... )
# no.readonly=TRUE

opar <- par(no.readonly=TRUE) # make a copy of current setting 
par(lty=2, pch=17)
# or
# par(lty=2)
# par(pch=17)
plot(dose, drugA, type='b')
par(opar)

# or 
plot(dose, drugA, type='b', lty=2, pch=17)

# 3.3.1 Symbols and Lines

plot(dose, drugA, type='b', lty=1, pch=24, lwd=2, cex=1)

# 3.3.2 Colors

# col
# col.axis
# col.lab
# col.main
# col.sub
# fg
# bg
# col=1, col='white', col='#FFFFF', 
# col=rgb(1, 1, 1), col=hsv(0, 0, 1)

# rainbow(), heat.colors(), terrian.colors(), 
# topo.colors(), cm.colors()
# grey(), grey(0:10/10)

n <- 10
mycolors <- rainbow(n)
pie(rep(1, n), labels=mycolors, col=mycolors)
mygreys <- grey(0:n/n)
pie(rep(1, n), labels=mygreys, col=mygreys)

n <- 20
mycolors <- rainbow(n)
pie(rep(1, n), labels=mycolors, col=mycolors)

# 3.3.3 Text characteristics

# cex()
# cex.axis()
# cex.lab()
# cex.main()
# cex.sub()

# par(font.lab=3, cex.lab=1.5, font.main=4, cex.main=2)

# font
# font.axis
# font.lab
# font.main
# font.sub
# ps
# family

# 3.3.4 Graph and margin dimensions

# pin (weight, height)
# mai (bottom, left, top, right) in inches
# mar (bottom, left, top, right) in lines

# par(pin=c(4, 3), mai=c(1, .5, 1, .2))

dose <- c(20, 30, 40, 50, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)
opar <- par(no.readonly=TRUE)
par(pin=c(2, 3))
par(lwd=2, cex=1.5)
par(cex.axis=.75, font.axis=3)
plot(dose, drugA, type='b', pch=19, lty=2, col='red',
     main='Clinical Trials for Drug A',
     sub='This is hypothetical data')
plot(dose, drugB, type='b', pch=23, lty=6, col='blue', bg='green')
par(opar)

# 3.4 Adding text, costomized axes, and legends

plot(dose, drugA, type='b', col='red',
     lty=2, pch=2, lwd=2, main='Clinical Trials for Drug A',
     sub='This is hypothetical data',
     xlab='Dosage', ylab='Drug Respose',
     xlim=c(0, 60), ylim=c(0, 70))

# 3.4.1 Title
# title(main='main title', sub='sub_title',
#        xlab='x-axis label', ylab='y-axis label')

title(main='Mt Title', col.main='red',
      sub='My Sub-title', col.sub='blue',
      xlab='My X-label', ylab='My Y-label',
      col.lab='green', cex.lab=0.75)

# 3.4.2 Axes

# axis(side, at=, labels=, pos=, lty=, col=, las=, tck=, ...)
# axes=FALSE
# frame.plot=TRUE
# xaxt='n', yaxt='n'

x <- c(1:10)
y <- x
z <- 10/x

opar=par(no.readonly=TRUE)

par(mar=c(5, 4, 4, 8) + 0.1) # increasing margin

plot(x, y, type='b',    # plot x versus y
     pch=21, col='red', 
     yaxt='n', lty=3, ann=FALSE) # ann removes the default setting.

lines(x, z, type='b', pch=22, col='blue', lty=2)

axis(2, at=x, labels=x, col.axis='red', lty=2)

axis(4, at=z, labels=round(z, digit=2),
     col.axis='blue', las=2,
     cex.axis=0.7, tck=-.01) 

mtext('y=1/x', side=4, line=3, 
      cex.lab=1, las=2, col='blue')  # adding title and text

title(main='An example of cteative axes',
      xlab= 'X values', ylab='Y=Z')

par(opar)

# MINOR TICK MARKS

# library(Hmisc)
# minor.tick(nx=n, ny=n, tick.ration=n)

# Reference lines

# abline()
# abline(h=yvalue, v=xvalue)

abline(h=c(1, 5, 7))

abline(v=seq(1, 10, 2), lty=2, col='blue')

# Legend

# legend(location, title, legend, ...)

dose <- c(20, 30, 40, 50, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)

opar <- par(no.readonly=TRUE)

par(pin=c(5, 5))

par(lwd=2, cex=1.5, font.lab=2)

plot(dose, drugA, type='b', 
     pch=15, lty=1, col='red', ylim=c(0, 60),
     main='Drug A vs. Drug B',
     xlab='Drug Dosage', ylab='Drug Response')

lines(dose, drugB, type='b',
      pch=17, lty=2, col='blue')

abline(h=c(30), lwd=1.5, lty=2, col='gray')

# library(Hmisc)
# minor.tick(nx=3, ny=3, tick.ration=0.5)

legend('topleft', inset=.05, title='Drug Type',
       c('A', 'B'), lty=c(1, 2), pch=c(15, 17),
       col=c('red', 'blue'), cex=0.7)

par(opar)

# 3.4.5 Text annotations

# text(), mtext()
# text(locations, 'text to place', pos, ...)
# mtext('text to place', side, line=n, ...)

attach(mtcars)
plot(wt, mpg,
     main='Mileage vs. Car Weight',
     xlab='Weight', ylab='Mileage',
     pch=18, col='blue')
text(wt, mpg,
     row.names(mtcars),
     cex=0.8, pos=1, col='red')
detach(mtcars)

opar <- par(no.readonly=FALSE)
par(cex=1.5, pin=c(5, 3))
plot(1:7, 1:7, type='n')
text(3, 3, 'Example of defualt text')
text(4, 4, family='mono', 'Example of mono-spaced text',
     cex=0.7, col='red')
text(5, 5, family='serif', 'Example of serif text')
par(opar)

# math annotations

# 3.5 Combining graphs

# par()
# layout()

# mfrow = c(nrows, ncols)
# mfcol = c(nrows, ncols)

attach(mtcars)
opar <- par(no.readonly=FALSE)
par(mfrow = c(2, 2))
plot(wt, mpg, main = 'Scatterplot of wt vs. mpg')
plot(wt, disp, main = 'Scatterplot of wt vs. mpg')
hist(wt, main = 'Histogram of wt')
boxplot(wt, main = 'Boxplot of wt')
par(opar)
detach(mtcars)


attach(mtcars)
opar <- par(no.readonly=FALSE)
par(mfrow = c(3, 1))
hist(wt)
hist(mpg)
hist(disp)
par(opar)
detach(mtcars)

# layout()

attach(mtcars)
layout(matrix(c(1, 1, 2, 3), 2, 2, byrow = TRUE))
layout.show(3)
hist(wt)
hist(mpg)
hist(disp)
detach(mtcars)

# widths=
# heights=
# lcm=

attach(mtcars)
layout(matrix(c(1, 1, 2, 3), 2, 2, byrow = TRUE),
       widths = c(3, 1), heights = c(1, 2))
hist(wt)
hist(mpg)
hist(disp)
detach(mtcars)

help(layout)

# 3.5.1 Creating a figure arrangement with fine control

# fig =

opar <- par(no.readonly = FALSE)
par(fig = c(0, .8, 0, .8))
plot(mtcars$wt, mtcars$mpg,
     xlab = 'Miles Per Gallon',
     ylab = 'Car Weight')
par(fig = c(0, 0.8, 0.55, 1), new=TRUE)
boxplot(mtcars$wt, horizontal = TRUE, axes = FALSE)
par(fig=c(0.65, 1, 0, 0.8), new = TRUE)
boxplot(mtcars$mpg, axes = FALSE)


opar <- par(no.readonly = FALSE)
par(fig = c(0, .8, 0, .8))
plot(mtcars$wt, mtcars$mpg,
     xlab = 'Miles Per Gallon',
     ylab = 'Car Weight')
par(fig = c(0, 0.8, 0.55, 1), new=TRUE)
boxplot(mtcars$wt, horizontal = TRUE, axes = FALSE)
par(fig=c(0.65, 1, 0, 0.8), new = TRUE)
boxplot(mtcars$mpg, axes = FALSE)

# 3.6 summary











