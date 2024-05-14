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

