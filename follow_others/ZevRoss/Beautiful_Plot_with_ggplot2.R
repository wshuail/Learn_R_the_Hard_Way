# source: http://dwz.cn/HnLxF

library(ggplot2)
library(tidyr)
# load the data
list.files()
nmmap <- read.csv('chicago-nmmaps.csv', sep = ',',
                   header = T, stringsAsFactors = F)

head(nmmap)
nmmap$date <- as.Date(nmmap$date)
head(nmmap)

nmmap <- nmmap[nmmap$date > as.Date('1996-12-31'), ]
nmmap$year <- substring(nmmap$date, 1, 4)
head(nmmap)

# the default plot
p <- ggplot(nmmap, aes(date, temp)) +
     geom_point(color = 'firebrick')
p

# add a title with ggtitle() or labs()
p <- p + ggtitle('Temperature')
p
p <- p + labs(title = 'Temperature')
p

# make title bold and a little space at the baseline
# face or vjust
p <- p + theme(plot.title = element_text(size = 20, 
                                         face = 'bold',
                                         vjust = 2))
p

# change the font with family
install.packages('extrafont')
library(extrafont)
p <- p + theme(plot.title = element_text(size = 20, 
                                         face = 'bold',
                                         vjust = 2,
                                         family = 'Bauhaus 93',
                                         lineheight = 0.8))
p

# change spacing in multiple line text
p <- p + theme(plot.title = element_text(size = 20, 
                                         face = 'bold',
                                         vjust = 2,
                                         lineheight = 0.8)) +
     ggtitle('This is longer title\nthan expected')
p

# add x axis and y axis
# labs() or xlab()
p <- p + labs(x = 'Date', 
              y = expression(paste('Temperature (',
                                   degree = F, ')')),
              title = 'Temperature')
p

# axis ticks and tick text
# theme() and axis.ticks.y()
p <- p + theme(axis.ticks.y = element_blank(),
               axis.text.y = element_blank())
p

# change the size and rotate the text
# axis.text.x()
p <- p + theme(axis.text.x = element_text(size = 20,
                                          angle = 50,
                                          vjust = 0.8))
p

# move the labes away from the plot
p <- p + theme(axis.text.x = element_text(color = 'forestgreen',
                                          vjust = 0.35),
               axis.text.y = element_text(color = 'cadetblue',
                                          vjust = -0.35))
p

# limit the axis range
p <- p + ylim(c(0, 60))
p
# alternative
p <- p + scale_y_continuous(limit = c(0, 90))
p
p <- p + coord_cartesian(ylim = c(0, 85))
p

# axes to be the same
ggplot(nmmap, aes(temp, temp + rnorm(nrow(nmmap), sd = 20))) +
     geom_point() +
     xlim(c(1, 150)) +
     ylim(c(1, 150)) +
     coord_equal()

# use a function to alter labels
ggplot(nmmap, aes(date, temp)) +
     geom_point(color = 'grey') + 
     labs(x = 'Date', y = 'Temperature') +
     scale_y_continuous(label = function(x){
          return (paste('My value is', x, 'degree.'))
     })

# working with the legend
p <- ggplot(nmmap, aes(date, temp, color = factor(season))) +
     geom_point()
p

# turn off the legend title
p <- p + theme(legend.title = element_blank())
p

# change the style of the legend title
p <- p + theme(legend.title = element_text(color = 'chocolate',
                                           size = 16,
                                           face = 'bold'))
p

# change the title of the legend
p <- p + theme(legend.title = element_text(color = 'chocolate',
                                           size = 16,
                                           face = 'bold')) +
     scale_color_discrete(name = 'This color is called\n
                          chocolate!?')
p


# change the backgroud boxes of the legend
p <- p + theme(legend.key = element_rect(fill = 'pink'))
p

# change the size of the symbol in the legend only
# guide() and guide_legend()

p <- p + guides(color = guide_legend(override.aes = list(size = 4)))
p

# leave a layer off the legend
# show_guide
p <- p + geom_text(data = nmmap, 
                   aes(date, temp, 
                       label = round(temp),
                       size = 4))
p

# turn a layer off
p <- p + geom_text(data = nmmap, 
                   aes(date, temp, 
                       label = round(temp),
                       size = 4),
                   show_guide = F)
p

# mutually adding legend items
# guides() and override.aes()

p <- ggplot(nmmap, aes(date, temp)) +
     geom_line(color = 'grey') +
     geom_point(color = 'red')
p     

# add legend
p <- ggplot(nmmap, aes(date, temp)) +
     geom_line(aes(color = 'Important line')) +
     geom_point(aes(color = 'My points'))
p

# change the color
p <- ggplot(nmmap, aes(date, temp)) +
     geom_line(aes(color = 'Important line')) +
     geom_point(aes(color = 'My points')) +
     scale_color_manual(name = '',
                        values = c('Important line' = 'grey',
                                   'My points' = 'red'))
p

p <- ggplot(nmmap, aes(date, temp)) +
     geom_line(aes(color = 'Important line')) +
     geom_point(aes(color = 'My points')) +
     scale_color_manual(name = '',
                        values = c('Important line' = 'grey',
                                   'My points' = 'red')) +
     guides(color = guide_legend(override.aes = list(linetype = c(1, 0),
                                                     shape = c(NA, 16))))
p

# change the panel color
# panel.background
ggplot(nmmap, aes(date, temp)) +
     geom_point(color = 'firebrick') + 
     theme(panel.background = element_rect(fill = 'grey77'))

# change the grid lines
# panel.grid.panel
ggplot(nmmap, aes(date, temp)) +
     geom_point(color = 'firebrick') + 
     theme(panel.background = element_rect(fill = 'grey77'),
           panel.grid.major = element_line(color = 'orange',
                                           size = 2),
           panel.grid.major = element_line(color = 'blue'))

# change the background color
# plot.background
ggplot(nmmap, aes(date, temp)) +
     geom_point(color = 'firebrick') + 
     theme(plot.background = element_rect(fill = 'grey'))

# change the plot margin 
# plot.margin
ggplot(nmmap, aes(date, temp)) +
     geom_point(color = 'firebrick') +
     labs(x = 'Date', y = 'Temperature') +
     theme(plot.background = element_rect(fill = 'darkseagreen'))

# change the margin
# top, right, bottom, left
library(grid)
ggplot(nmmap, aes(date, temp)) +
     geom_point(color = 'firebrick') +
     labs(x = 'Date', y = 'Temperature') +
     theme(plot.background = element_rect(fill = 'darkseagreen'),
           plot.margin = unit(c(1, 6, 1, 6), 'cm'))

# Creating multi-panel plots

# create a single row of plots based on one variable
# facet_wrap()
ggplot(nmmap, aes(date, temp)) + 
     geom_point(color = 'aquamarine4') + 
     facet_wrap(~year, nrow = 1)

# create a matrix of plots based on variable 
ggplot(nmmap, aes(date, temp)) + 
     geom_point(color = 'aquamarine4') + 
     facet_wrap(~year, nrow = 2)

ggplot(nmmap, aes(date, temp)) + 
     geom_point(color = 'chartreuse4') + 
     facet_wrap(~year, ncol = 2)

# allow scale to roam free
ggplot(nmmap, aes(date, temp)) + 
     geom_point(color = 'aquamarine4') + 
     facet_wrap(~year, nrow = 2, scale = 'free')

# create a grid of plots using two variables
ggplot(nmmap, aes(date, temp)) + 
     geom_point(color = 'darkgoldenrod4') + 
     facet_grid(year ~ season)

ggplot(nmmap, aes(date, temp)) + 
     geom_point(color = 'darkgoldenrod4') + 
     facet_grid(season ~ year)

# put two potentially unrelated plots side by side
# pushViewport() and grid.arrange()

p1 <- ggplot(nmmap, aes(date, temp)) + 
     geom_point(color = 'firebrick')
p1
p2 <- ggplot(nmmap, aes(temp, o3)) +
     geom_point(color = 'olivedrab')
p2

library(grid)
pushViewport(viewport(layout = grid.layout(1, 2)))
print(p1, vp = viewport(layout.pos.row = 1,
                        layout.pos.col = 1))
print(p2, vp = viewport(layout.pos.row = 1,
                        layout.pos.col = 2))

# an anternitive wat
install.packages('gridExtra')
library(gridExtra)
grid.arrange(p1, p2, ncol = 2)

# Working with theme
library("devtools")
install_github("jrnold/ggthemes")
library(ggthemes)
# use a new theme
# theme_xxx
ggplot(nmmap, aes(date, temp, color = factor(season))) +
     geom_point() +
     ggtitle('This plot looks at different with the default') +
     theme_economist() +
     scale_color_economist()

theme_set(theme_gray(base_size = 25))
ggplot(nmmap, aes(date, o3)) + geom_point(color = 'red')

# creating a custom theme
theme_gray

function (base_size = 12, base_family = "") 
{
     theme(
          line = element_line(colour = "black", size = 0.5, linetype = 1, lineend = "butt"), 
          rect = element_rect(fill = "white", colour = "black", size = 0.5, linetype = 1), 
          text = element_text(family = base_family, face = "plain", colour = "black", size = base_size, hjust = 0.5, vjust = 0.5, angle = 0, lineheight = 0.9), 
          
          axis.text = element_text(size = rel(0.8), colour = "grey50"), 
          strip.text = element_text(size = rel(0.8)), 
          axis.line = element_blank(), 
          axis.text.x = element_text(vjust = 1), 
          axis.text.y = element_text(hjust = 1), 
          axis.ticks = element_line(colour = "grey50"), 
          axis.title.x = element_text(), 
          axis.title.y = element_text(angle = 90), 
          axis.ticks.length = unit(0.15, "cm"), 
          axis.ticks.margin = unit(0.1, "cm"), 
          
          legend.background = element_rect(colour = NA), 
          legend.margin = unit(0.2, "cm"), 
          legend.key = element_rect(fill = "grey95", colour = "white"), 
          legend.key.size = unit(1.2, "lines"), 
          legend.key.height = NULL, 
          legend.key.width = NULL, 
          legend.text = element_text(size = rel(0.8)), 
          legend.text.align = NULL, 
          legend.title = element_text(size = rel(0.8), face = "bold", hjust = 0), 
          legend.title.align = NULL, 
          legend.position = "right", 
          legend.direction = NULL, 
          legend.justification = "center", 
          legend.box = NULL, 
          
          panel.background = element_rect(fill = "grey90", colour = NA), 
          panel.border = element_blank(), 
          panel.grid.major = element_line(colour = "white"), 
          panel.grid.minor = element_line(colour = "grey95", size = 0.25), 
          panel.margin = unit(0.25, "lines"), 
          panel.margin.x = NULL, 
          panel.margin.y = NULL, 
          
          strip.background = element_rect(fill = "grey80", colour = NA), 
          strip.text.x = element_text(), 
          strip.text.y = element_text(angle = -90), 
          
          plot.background = element_rect(colour = "white"), 
          plot.title = element_text(size = rel(1.2)), 
          plot.margin = unit(c(1, 1, 0.5, 0.5), "lines"), complete = TRUE)
}

# working with color

# a categorical or continuous variable
# Categorical variables: manually select the colors 
# (scale_color_manual())

ggplot(nmmap, aes(date, temp, color = factor(season))) +
     geom_point() +
     scale_color_manual(values = c('dodgerblue4', 
                                   'darkolivegreen4',
                                   'darkorchid3', 
                                   'goldenrod1'))


# Categorical variables: try a built-in palette (based on 
# colorbrewer2.org) (scale_color_brewer()):
ggplot(nmmap, aes(date, temp, color = factor(season))) +
     geom_point() +
     scale_color_brewer(palette = 'Set1')

# tableau color
ggplot(nmmap, aes(date, temp, color = factor(season))) +
     geom_point() +
     scale_color_tableau()

# continuous variales
# scale_color_gradient(), scale_color_gradient2()

ggplot(nmmap, aes(date, temp, color = o3)) + geom_point()
# identical plot
ggplot(nmmap, aes(date, temp, color = o3)) + 
     geom_point() +
     scale_color_gradient()

# manually change the low and high score
ggplot(nmmap, aes(date, temp, color = o3)) + 
     geom_point() +
     scale_color_gradient(low = 'darkkhaki',
                          high = 'darkgreen')

# diverging color theme
mid <- mean(nmmap$o3)
ggplot(nmmap, aes(date, temp, color = o3)) + 
     geom_point() +
     scale_color_gradient2(low = 'blue',
                           high = 'red',
                           mid = 'white',
                           midpoint = mid)

# Working with annotation
# Add text annotation in the top-right, top-left etc. 
# annotation_custom() and textGrob()

library(grid)
my_grob <- grobTree(textGrob('This text stays in place',
                             x = 0.1, y = 0.95, hjust = 0,
                             gp = gpar(col = 'blue', 
                                       fontsize = 15,
                                       fontface = 'italic')))

ggplot(nmmap, aes(temp, o3)) + geom_point(color = 'firebrick') +
     annotation_custom(my_grob)

#

my_grob <- grobTree(textGrob('This text stays in place',
                             x = 0.1, y = 0.95, hjust = 0,
                             gp = gpar(col = 'blue', 
                                       fontsize = 15,
                                       fontface = 'italic')))

ggplot(nmmap, aes(temp, o3)) + 
     geom_point(color = 'firebrick') +
     annotation_custom(my_grob) +
     facet_wrap(~ season, scale = 'free')

# Working with coordinate
# flip a plot on its side
# coord_flip()

ggplot(nmmap, aes(season, o3)) + 
     geom_boxplot(fill = 'chartreuse4') +
     coord_flip()

# Working with plot type
# Alternatives to the box plot 
# geom_jitter() and geom_violin()

# start with box plot
p <- ggplot(nmmap, aes(season, o3))
p + geom_boxplot(fill = 'darkseagreen4')

p + geom_point()

# jitter and points
# geom_jitters
p + geom_jitter(alpha = 0.5, aes(color = season),
                position = position_jitter(width = 0.2))

# violin plot
# geom_violin
p + geom_violin(alpha = 0.5, color = 'gray') +
     geom_jitter(aes(color = season),
                 position = position_jitter(width = 0.2),
                 alpha = 0.5) +
     coord_flip()


# add a ribbon
# geom_ribbon()
nmmap$o3run <- as.numeric(filter(nmmap$o3, rep(1/30, 30),
                                 sides = 2))
head(nmmap)
ggplot(nmmap, aes(date, o3run)) + 
     geom_line(color = 'lightpink4', lwd = 1)

# add a ribbon
ggplot(nmmap, aes(date, o3run)) + 
     geom_ribbon(aes(ymin = 0, ymax = o3run),
                 fill = 'lightpink3', color = 'lightpink4') +
     geom_line(color = 'lightpink4', lwd = 1)

nmmap$mino3 <- nmmap$o3run - sd(nmmap$o3run, na.rm = T)
nmmap$maxo3 <- nmmap$o3run + sd(nmmap$o3run, na.rm = T)
ggplot(nmmap, aes(date, o3run)) + 
     geom_ribbon(aes(ymin = mino3, ymax = maxo3),
                 fill = 'lightpink3', color = 'lightpink4',
                 alpha = 0.4) +
     geom_line(color = 'lightpink4', lwd = 1)

# create a tiled correlation plot
# geom_tile()
thecor <- round(cor(nmmap[,sort(c("death", "temp", "dewpoint", 
                                   "pm10", "o3"))], 
                    method="pearson", 
                    use="pairwise.complete.obs"), 2)
thecor[lower.tri(thecor)] <- NA
thecor

# reshape the data
library(reshape2)
thecor <- melt(thecor)
thecor
thecor$Var1 <- as.character(thecor$Var1)
thecor$Var2 <- as.character(thecor$Var2)
thecor <- na.omit(thecor)
thecor

# scale_fill_gradient2 not the scale_color_gradient2
ggplot(thecor, aes(Var1, Var2)) + 
     geom_tile(data = thecor, aes(fill = value), color = 'white') +
     scale_fill_gradient2(low = 'blue', mid = 'white', 
                           high = 'red', midpoint = 0,
                           limit = c(-1, 1),
                           name = 'Corelation Pearson') + 
     theme(axis.text.x = element_text(angle = 45, vjust = 1,
                                      size = 11, hjust = 1)) +
     coord_flip()

# working with smooth

# stat_smooth
ggplot(nmmap, aes(date, temp)) +
     geom_point(color = 'firebrick') +
     stat_smooth()
# spacify the formula
ggplot(nmmap, aes(date, temp)) +
     geom_point(color = 'grey') +
     stat_smooth(method="gam", formula=y~s(x,k=10), 
                 col="darkolivegreen2", se=FALSE, size=1)+
     stat_smooth(method="gam", formula=y~s(x,k=30), 
                 col="red", se=FALSE, size=1)+
     stat_smooth(method="gam", formula=y~s(x,k=500), 
                 col="dodgerblue4", se=FALSE, size=1)

# adding a linear fit
# stat_smooth(method = 'lm')
ggplot(nmmap, aes(temp, death)) +
     geom_point(color = 'firebrick') +
     stat_smooth(method = 'lm', se = F)

# the cumbersome way
lmTemp<-lm(death~temp, data=nmmap)
ggplot(nmmap, aes(temp, death)) + 
     geom_point(col="firebrick") +
     geom_abline(intercept=lmTemp$coef[1], slope=lmTemp$coef[2])
















