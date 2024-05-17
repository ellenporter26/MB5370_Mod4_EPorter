# --- Workshop 4 - Spatial Data

# install required packages:
install.packages("sf")
install.packages("terra")
install.packages("tmap")

# load packages:
library(tidyverse)
library(sf) # simple features
library(terra) # for raster
library(tmap) # thematic maps
library(readr)

# load copepod data:
dat <- read_csv("copepod/copepods_raw.csv")
dat

## Data exploration

# Check coordinates:
library(ggplot2)
ggplot(dat) +
  aes(x=longitude, y=latitude, color=richness_raw) +
  geom_point()

# look at richness data
ggplot(dat, aes(x = latitude, y = richness_raw)) + 
  stat_smooth() + 
  geom_point()


## Getting going with maps
# Repeat above map of richness but this time using specialist mapping for GIS

# turn data into a simple features collection
sdat <- st_as_sf(dat, coords = c("longitude", "latitude"),
                 crs=4326)

## Coordinate reference systems
# find out what coordinate system a certin crs number represents:
crs4326 <- st_crs(4326)
crs4326$name # not working but ok
crs4326$wkt # check what WKT looks like

## Feature collections (points)
sdat # check now to see geometry are in 'points' form, similar to GIS

## Cartography
# plot richness column:
plot(sdat["richness_raw"])
# be sure to remember that if we just used plot(sdat), it would have 
#plotted everything. By using sf with [], we are able to specify which variable to plot.

## Thematic maps for communication
# use tmap to add layers like ggplot but for maps
tm <- tm_shape(sdat) +
  tm_dots(col = "richness_raw")

# customise maps & save
tmap_save(tm, filename = "Richness-map.png",
          width=600, height=600, units = "mm")


## Mapping spatial polygons as layers

# Loading shapefiles

# read shapefile directly into R:
aus <- st_read("copepod/spatial-data/Aussie/Aussie.shp")
shelf <- st_read("copepod/spatial-data/aus_shelf/aus_shelf.shp")

# check data has loaded correctly
aus # indicated shape of Australia
shelf # indicated shape of map

# Mapping your polygons
# map of aus:
tm_shape(shelf)+
  tm_polygons()

# Add shape of Aus on top on top of shelf, then finally copepod data:
tm_shape(shelf, bbox=sdat) +
  tm_polygons() +
  tm_shape(aus) +
  tm_polygons() +
  tm_shape(sdat) +
  tm_dots()

# Explore tmap to customise map:
tmap_style("beaver") # changes colour theme

# open tmap vignette:
vignette('tmap-getstarted')

## Do exercises from vignette:
data("World")
tm_shape(World) +
  tm_polygons("HPI")

# Interactive maps:
tmap_mode("view")
tm_shape(World) +
  tm_polygons("HPI")

# Multiple shapes and layers:
data(World, metro, rivers, land)
tmap_mode("plot") # set t_map mode to plotting from interactive

tm_shape(land) +
  tm_raster("elevation", palette = terrain.colors(10)) +
  tm_shape(World) +
  tm_borders("white", lwd=.5) +
  tm_text("iso_a3", size="AREA") +
  tm_shape(metro) +
  tm_symbols (col = "red", size = "pop2020", scale = .5)+
  tm_legend(show=FALSE)

# Facets
# 3 ways to create them:

#1. assign multiple variable names to one aesthetic:
tmap_mode("view")
tm_shape(World) +
  tm_polygons(c("HPI", "economy")) +
  tm_facets(sync = TRUE, ncol = 2)

#2. splitting spatial data with the by argument:
tmap_mode("plot") #tmap mode set to plotting

data(NLD_muni)

NLD_muni$perc_men <- NLD_muni$pop_men / NLD_muni$population * 100

tm_shape(NLD_muni) +
  tm_polygons("perc_men", palette = "RdYlBu") +
  tm_facets(by = "province")

#3. By using the tmap_arrange function:
tmap_mode("plot") #tmap mode set to plotting

data(NLD_muni)
tm1 <- tm_shape(NLD_muni) + tm_polygons("population", convert2density = TRUE)
tm2 <- tm_shape(NLD_muni) + tm_bubbles(size = "population")

tmap_arrange(tm1, tm2)


# Basemaps and overlay tile maps
# add tilemaps
tmap_mode("view")
tm_basemap("Stamen.Watercolor") +
  tm_shape(metro) + tm_bubbles(size = "pop2020", col = "red") +
  tm_tiles("Stamen.TonerLabels")

# Options and styles
tmap_mode("plot") # tmap mode set back to plotting

tm_shape(World) +
  tm_polygons("HPI") +
  tm_layout(bg.color = "skyblue", inner.margins = c(0, .02, .02, .02))

# change background to black and text to white
tmap_options(bg.color = "black", legend.text.color = "white")
tm_shape(World) +
  tm_polygons("HPI", legend.title = "Happy Planet Index")

# a style is a configuration of the tmap options:
tmap_style("classic")
tm_shape(World) +
  tm_polygons("HPI", legend.title="Happy Planet Index")

# see what options have been changed:
tmap_options_diff()

# reset the options to the default values
tmap_options_reset()
# new styles an be created, see ?tmap_options

## Exporting maps
tm <-  tm_shape(World) +
  tm_polygons("HPI", legend.title="Happy Planet Index")
#save an image ("plot" mode)
tmap_save(tm, filename = "world_map.png")

#save as stand-alone HTML file ("view" mode)
tmap_save(tm, filename="world_map.html")

### BOOKDOWN Tutorial - read through
