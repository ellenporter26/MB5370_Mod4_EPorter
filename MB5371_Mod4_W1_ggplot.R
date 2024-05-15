# ------ Workshop 1 - ggPlot --------
#install.packages("tidyverse")
library(tidyverse)

# Load mpg from R
mpg

# Create first ggplot
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy))

#change point colour by class:
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour = class))

#change point size by class:
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size=class))

# change point transparency by class (alpha)
ggplot(data=mpg) + geom_point(mapping = aes(x=displ, y=hwy, alpha = class))

#change point shape by class
ggplot(data=mpg) + geom_point(mapping = aes(x=displ, y=hwy, shape = class))

# colour of points
ggplot(data=mpg) + geom_point(mapping = aes(x=displ, y=hwy), colour = "blue")

# question to try out:
ggplot(data=mpg) + geom_point(mapping = aes(x=displ, y=hwy, colour= displ <5))

## Facet and panel plots ##

#make first facet plot divided by 'class' variable
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy))+
  facet_wrap(~class, nrow=2)

#make facet plot with drv and cyl:
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy))+
  facet_wrap(drv~cyl)

# read ?facetwrap. What does nrow do? What does ncol do?
#Number of rows and columns

## Fitting simple lines ##

#scatterplot with smooth line
ggplot(data=mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy))
# smooth line is a much better choice to display data

#change line type and plot based on their drv:
ggplot(data=mpg) +
  geom_smooth(mapping=aes(x=displ, y= hwy, linetype=drv, colour = drv))

# Use group argument to show that the data is in fact grouped:
ggplot(data=mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy, group = drv))

# change the colour of each line based on drv value:
ggplot(data=mpg) +
  geom_smooth(
    mapping=aes(x=displ, y=hwy, colour = drv),
    show.legend = FALSE
  )

# Plot multiple geoms on a ginle plot:
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy))+
  geom_smooth(mapping = aes(x=displ, y=hwy))
#not great practice b/c you have to keep repeating the x and y values.

# Make same plot as above but more efficient programming:
ggplot(data=mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point() +
  geom_smooth()
#makes same plot!

# style points themselves:
ggplot(data=mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point(mapping = aes(color=class)) +
  geom_smooth()

#use a filter to select a subset of the data and plot only that data:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)


## Transformations and Stats ##
# import diamonds dataset
diamonds

#plot dataset
ggplot(data=diamonds) +
  geom_bar(mapping=aes(x=cut))

#re-create last plot using stat_count instead of geom_bar:
ggplot(data=diamonds) +
  stat_count(mapping=aes(x = cut))

# change the default stat (i.e., count or summary) to identity:
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)
demo

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

#display bar chart of the proportion of the total diamond dataset rather than a count:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))

# show information about the transformations in my plot:
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

## Aesthetics adjustments ##
# Use aesthetics like colour or fill to change aspects of bar colours:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

# Use aesthetics to colour by another variable (i.e., clarity):
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

# Position Adjustments #

# To alter transparency (alpha):
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")

#To color the bar outlines with no fill color
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")

# Make each set of stacked bars the same height:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

# 'Dodge' places overlapping objects directly beside one another:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

# 'Jitter' adds a small amount of random noise to each point to avoid overplotting when points overlap (useful for scatterplots only):
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

# END #


# ------ Workshop 2 - ggPlot --------

## Labels

# add labels with labs function:
library(ggplot2)
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(title = "Fuel efficiency generally decreases with engine size")

# add subtitle and caption:
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(
    title = "Fuel efficiency generally decreases with engine size",
    subtitle = "Two seaters (sports cars) are an exception because of their light weight",
    caption = "Data from fueleconomy.gov"
  )

#Use labs() to replace axis labels and legend titles:
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_smooth(se = FALSE) +
  labs(
    x = "Engine displacement (L)",
    y = "Highway fuel economy (mpg)",
    colour = "Car type"
  ) 

## Annotations

# add text to the plot like textual labels:
library(tidyr)
library(dplyr)
best_in_class <- mpg %>% #first, filter the data and add a label that calls in the values from the data frame
  group_by(class) %>%
  filter(row_number(desc(hwy)) == 1)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_text(aes(label = model), data = best_in_class)

# Use nudge() to avoid label overlap in the plot.

## Scales

# see default scales by ggplot:
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class))

# Tweak scales by offering a character vector indicating the start and end of your limit (i.e., limits are 0-12):
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  scale_x_continuous(limits = c(0,12)) +
  scale_y_continuous(limits = c(0,12)) +
  scale_colour_discrete()

## Axis ticks

#Change ticks on axis:
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_y_continuous(breaks = seq(15, 40, by = 5))

# Sequentially increases by 5 between 15 and 40.
seq(15, 40, by = 5)

# Use labels set to NULL to suppress the labels altogether:
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_x_continuous(labels = NULL) +
  scale_y_continuous(labels = NULL)

## Legends and colour schemes:

# Change the position of a legend:
base <- ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class))

base + theme(legend.position = "left")
base + theme(legend.position = "top")
base + theme(legend.position = "bottom")
base + theme(legend.position = "right") # the default
base + theme(legend.position = "none") # suppresses the legend altogether

# Replacing a scale

# Switch out scale to a log10 one & turn points into bins:
ggplot(diamonds, aes(carat, price)) +
  geom_bin2d() + 
  scale_x_log10() + 
  scale_y_log10()

# Apply colour scale:
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv))

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv)) +
  scale_colour_brewer(palette = "Set1")

# Add redundant shape mapping (great to interpret black/white graphs):
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv, shape = drv)) +
  scale_colour_brewer(palette = "Set1")

# Use predefined colours that I've set myself:
presidential %>%
  mutate(id = 33 + row_number()) %>%
  ggplot(aes(start, id, colour = party)) +
  geom_point() +
  geom_segment(aes(xend = end, yend = id)) +
  scale_colour_manual(values = c(Republican = "red", Democratic = "blue"))

# Use the 'viridis' colour scheme:
#install.packages('viridis')
#install.packages('hexbin')
library(viridis)
library(hexbin)
df <- tibble( # make a fake dataset to plot it
  x = rnorm(10000),
  y = rnorm(10000)
)
ggplot(df, aes(x, y)) +
  geom_hex() + # a new geom
  coord_fixed()

ggplot(df, aes(x, y)) +
  geom_hex() +
  viridis::scale_fill_viridis() +
  coord_fixed()

## Themes

# Let's explore some built-in functions:

# Bw
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_bw()

# Light
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_light()

# Classic
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_classic()

# Dark
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_dark()

# Set your own theme:
theme (panel.border = element_blank(),
       panel.grid.minor.x = element_blank(),
       panel.grid.minor.y = element_blank(),
       legend.position="bottom",
       legend.title=element_blank(),
       legend.text=element_text(size=8),
       panel.grid.major = element_blank(),
       legend.key = element_blank(),
       legend.background = element_blank(),
       axis.text.y=element_text(colour="black"),
       axis.text.x=element_text(colour="black"),
       text=element_text(family="Arial")) 

## Saving and exporting plots

# Use ggsave() to save the most recent plot:
ggplot(mpg, aes(displ, hwy)) + geom_point()

ggsave("my-plot.pdf")
#> Saving 7 x 4.32 in image

# Play with width and height arguments:
ggsave("my-plot.pdf", width = 12, height = 24)

  
  
