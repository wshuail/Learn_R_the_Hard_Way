# chapter 15 Advanced graphics

# 16.1 the four grapgic systems in R

# 16.2 tha lattice package

library(lattice)

histogram(~height | voice.part, data = singer,
          main = 'Distribution of height by voice pitch',
          xlab = 'Height (inches)')

# graph_function(formula, data = , options)

attach(mtcars)
gear <- factor(gear, levels = c(3, 4, 5),
               labels = c('3 gears', '4 gears', '5 gears'))
cyl <- factor(cyl, levels = c(4, 6, 8),
              labels = c('4 cylinders', '6 cylinders',
                         '8 cylinders'))

densityplot(~mpg,
            main = 'Density plot',
            xlab = 'Miles per gallon')

densityplot(~mpg | cyl,
            main = 'Density plot by number of cylinders',
            xlab = 'Miles per gallon')

bwplot(~mpg | gear,
       main = 'Box plots by cylinders and gears',
       xlab = 'Miles per gallon',
       ylab = 'Cylinders')

xyplot(mpg ~ wt | cyl*gear,
       main = 'Scatter plots by cylinders and gears',
       xlab = 'Car weight',
       ylab = 'Miles per gallon')

cloud(mpg ~ wt * qsec | cyl,
      main = '3D scatter plots by cylinders')

dotplot(cyl ~ mpg | gear,
        main = 'Dot plot by numbers of gears and cylinders',
        xlab = 'Miles per gallon')
spolm(mtcars[c(1, 3, 4, 5, 6)],
      main = 'Scatter plot matrix for mtcars data')

detach(mtcars)

library(lattice)
mygraph <- densityplot(~ height|voice.part,
                       data = singer)
plot(mygraph)

update(mygraph, col = 'red', pch = 16, cex = 0.8,
       jitter = 0.05, lwd = 2)

# 16.2.1 conditioning variables

# myshingle <- equal.count(x, number = , overlap = proportion)

displacement <- equal.count(mtcars$disp, number = 3,
                            overlap = 0)

xyplot(mpg ~ wt | displacement, data = mtcars,
       main = 'Miles per gallon vs Weight by Engine displacement',
       xlab = 'Weight', ylab = 'Miles per gallon',
       layout = c(3, 1), aspect = 1.5)

# 16.2.2 panel function

# xyplot(mpg ~ wt| displacement, data = mtcars)
# xyplot(mpg ~ wt| displacement, data = mtcars, 
#        panel = panel.xyplot)

displacement <- equal.count(mtcars$disp, number = 3,
                            overlap = 0)

mypanel <- function(x, y){
     panel.xyplot(x, y, pch =19)
     panel.rug(x, y)
     panel.grid(h = -1, v = -1)
     panel.lmline(x, y, col = 'red', lwd = 1, lty = 2)
}

xyplot(mpg ~ wt | displacement, data = mtcars,
       main = 'Miles per gallon vs Weight by Engine displacement',
       xlab = 'Weight', ylab = 'Miles per gallon',
       layout = c(3, 1), aspect = 1.5,
       panel = mypanel)

library(lattice)
mtcars$transmission <- factor(mtcars$am, 
                              levels = c(0, 1),
                              labels = c('Automatic', 'Manual'))
panel.smoother <- function(x, y){
     panel.grid(h=-1, v=-1)
     panel.xyplot(x, y)
     panel.loess(x, y)
     panel.abline(h = mean(y),
                  lwd = 2,
                  lty = 2,
                  col = 'green')
}

xyplot(mpg~disp|transmission, data = mtcars,
       scales = list(cex = 0.8, col = 'red'),
       panel = panel.smoother,
       xlab = 'Displacement',
       ylab = 'Miles per gallon',
       main = 'MPG vs Displacement by transmission type')

# 16.2.3 grouping variables

library(lattice)
mtcars$transmission <- factor(mtcars$am, levels = c(0, 1),
                              labels = c('Automatic', 'Manual'))
densityplot(~mpg, data = mtcars,
            group = transmission,
            main = 'MPG distribution by transmission type',
            xlab = 'Miles per gallon',
            auto.key = TRUE)

# auto.key(space = 'right', columns = 1, title = ' ')

library(lattice)
mtcars$transmission <- factor(mtcars$am, levels = c(0, 1),
                              labels = c('Automatic', 'Manual'))
colors <- c('red', 'blue')
lines <- c(1, 2)
points <- c(16, 17)

key.trans <- list(title = 'Transmission',
                  space = 'bottom',
                  columns = 2,
                  text = list(levels(mtcars$transmission)),
                  points = list(pch = points,
                                col = colors),
                  lines = list(lty = lines,
                               col = colors),
                  cex.title = 1,
                  cex = 0.9)

densityplot(~mpg, data = mtcars,
            group = transmission,
            main = 'MPG distribution by transmission type',
            xlab = 'Miles per gallon',
            pch = points,
            lty = lines,
            col = colors,
            lwd = 2,
            jitter = 0.005,
            key = key.trans)



# 16.3 the ggplot2 package

# qplot(x, y, data = , color = , shape = , size = ,
#       alpha = , geom = , method = , formula = ,
#       facets = , xlim = , ylim = , xlab = , 
#       ylab = , main = , sub = )

library(ggplot2)
mtcars$cylinder <- factor(mtcars$cyl)
qplot(cylinder, mpg, data = mtcars,
      geom = c('boxplot', 'jitter'),
      fill = cylinder,
      main = 'Box plots with superimposed data points',
      xlab = 'numbers of cylinders',
      ylab = 'Miles per gallon')

head(mtcars$am)

transmission <- factor(mtcars$am, levels = c(0, 1),
                      labels = c('Automatical', 'Manual'))
qplot(wt, mpg, data = mtcars,
      color = transmission, shape = transmission,
      geom = c('point', 'smooth'),
      method = 'lm', formula = y~x,
      xlab = 'Weight',
      ylab = 'Miles per gallon',
      main = 'Regression example')

mtcars$cyl <- factor(mtcars$cyl, levels = c(4, 6, 8),
                     labels = c('4 cylinders', '6 cylinders',
                                '8 cylinders'))
mtcars$am <- factor(mtcars$am, levels = c(0, 1),
                    labels = c('Automatical', 'Manual'))
qplot(cyl, am, data = mtcars, facets = am~cyl, size = hp)

library(lattice)
qplot(height, data = singer, geom = c('density'),
      facets = voice.part~.,
      fill = voice.part)



























