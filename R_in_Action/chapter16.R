# chapter 15 Advanced graphics

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



























