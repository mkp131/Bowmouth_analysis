# Install packages
#install.packages(c("tidyverse", "rnaturalearthhires", "sf", "ggplot2", "ggrepel",
                   'rnaturalearth'))
#install.packages("rnaturalearthhires")

# Load packages
# package for data manipulation
library(tidyverse)

# packages for plotting
library(ggplot2)
library(ggrepel)

# package for working with spatial data
# sf has functions compatible with ggplot
library(sf)

# package for loading world map
library(rnaturalearth)
library(rnaturalearthhires)
# if cant load above then use devtools::install_github("ropensci/rnaturalearthhires"
library(viridisLite)
library(ggspatial)

# Set dark-on-light theme for maps
theme_set(theme_light())

# rnatural earth provides map of all countries, ne_countries pulls country data and 
# choose scale (if want large then need rnaturalearthires)
world <- ne_countries(scale = "medium", returnclass = "sf")
# Class of object world will show us class and the column names
class(world)

# names will show us that world consists of 64 columns
names(world)

# Narrow down map to certain region: By adding the coord_sf() layer with the arguments xlim and ylim, we can zoom to any part. expand = FALSE ensures
# map boundaries are cut off at defined coordinates and no buffer space is provided. Coordinates listed as xlim Longitude and longitude, then ylim,
# latitude and latitude of boundaries
# With my region coordinates: Dubai to Bangladesh

#world %>% ggplot() +
#  geom_sf() +
#  coord_sf(xlim = c(23.94462692660258, 100.25850522440837), ylim =  
 #            c(40.350447135475605, 3.1895747788411266), expand = FALSE)

# Load csv file containing coordinates
wedge_coord <- read_csv("Data/GPS_coord_for_R_bowmouth - consolidated.csv")
spec(wedge_coord)
wedge_coord_1 = wedge_coord[, c(3, 4, 7)]
print(wedge_coord_1)

# convert to sf (simple features) function: st_as_sf converts the # # coordinates to sf object we need to identify which columns are the # coordinates that need to be converted and the coordinate reference # system (crs) crs = 4326 is the most commonly used code by 
# organisations that provide GIS data

bowmouth_sf <- st_as_sf(wedge_coord_1, coords = c("Longitude", "Latitude"),
                        crs = 4326)
bowmouth_sf

# changing theme to change land colour and ocean colour
mytheme <- theme(text = element_text(family = 'Avenir')
                 ,panel.grid.major = element_line(color = '#cccccc' 
                                                  ,linetype = 'dashed'
                                                  ,size = .3
                 )
                 ,panel.background = element_rect(fill = 'aliceblue')
                 ,plot.title = element_text(size = 32)
                 ,plot.subtitle = element_text(size = 14)
                 ,axis.title = element_blank()
                 ,axis.text = element_text(size = 10)
)
land_colour <- c('antiquewhite1')

# Add scale bar and compass, ggspatial package. the annotation_scale # adds the scale bar, the argument location is set to tr (=top 
# right) the width_hint defines the width of the bar. The 
# annotation_north_arrow() uses location as an argument. You can 
# fine tune using pad_x and pad_y. If the argument which_north is 
# true then the compass always points towards the north pole

#annotation_scale(
 # location = "tr",
  #width_hint = 0.5) +
  #annotation_north_arrow(location = "tr", which_north = "true", 
   #                      pad_x = unit(0.3, "in"), pad_y = unit(0.5, "in"),
    #                     style = north_arrow_fancy_orienteering)

# Add labels to countries and oceans: geom_text adds layer of text to map using coordinates. 
# hjust adjusts horizontally, vjust adjusts vertically, nudge_x adjusts horizontally, nudge_y vertically
# ggrepel uses function geom_text_repel to move labels around so they dont overlap
# st_centroid defines centroid of countries from sf package 
# not working issues with sf package 

# choose column in world dataframe
world
world[c('name', 'geometry')]

# plot(sf :: st_geometry())
# world_points <- st_centroid(world)
# world_points
geometries <- world$geometry
geometries
class(geometries)
centroids <- st_centroid(geometries)
centroids
class(centroids)
centroid_coords <- st_coordinates(centroids)
centroid_coords
class(centroid_coords)
world_points <- cbind(world, centroid_coords)
world_points


#geom_text(data= world_points, aes(x=X, y=Y, label=name),
 #         color = "darkblue", fontface = "bold", size = 9, check_overlap = FALSE) +
  #annotate(geom = "text", x = 12.5, y = 65, label = "Arabian Sea", 
   #        fontface = "italic", color = "grey22", size = 4) +

# adding labels
#geom_sf_label(data=world_points,aes(label=name),
 #             nudge_x = c(1,-5.5,2,2,-1,-2,2.5,1,-7,1,4), 
#              nudge_y = c(3.5,-8,1.5,5.5,2.5,1.5,6,-1.75,-0.5,2.5,1.5)) +

# Try to nudge names to make map more readable
#cnames$nudge_y <- -1
#cnames$nudge_y[]



#library(maps)
cnames_df <- world[world$name = c(
  "Saudi Arabia", "United Arab Emirates", "India", "Sri Lanka", "Bangladesh"),]

# Final Map: pch = point characteristics, 21 is a circle with a # darker border, labs = labels, element.text() can alter font, size etc

bowmouth_map_colour <- world %>% 
  ggplot() +
  geom_sf(data = world, fill = land_colour, size = 0.4) +
  geom_point(data = wedge_coord_1,
             mapping = aes(x = Longitude, y = Latitude, size = `Number of Samples`), 
             colour="Dark Blue",
             fill="Blue 2",
             pch = 21,
             alpha = I(0.4)) + 
  geom_text(data= world_points, aes(x=X, y=Y, label=name),
           color = "darkblue", fontface = "bold", size = 3, check_overlap = TRUE) +
  annotate(geom = "text", x = 65, y = 12.5, label = "Arabian Sea", 
           fontface = "italic", color = "grey22", size = 4) +
  coord_sf(xlim = c(35.94462692660258, 95.25850522440837), ylim =  
             c(32.350447135475605, 5.1895747788411266), expand = FALSE) +
  mytheme +
  labs(x = "Longitude", y = "Latitude", fill = "", 
       title = "Bowmouth guitarfish landing sites") +
  theme(panel.grid = element_line(colour = "transparent"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        legend.text = element_text(size = 10),
        legend.title = element_text(size = 14),
        plot.title = element_text(face = "bold", size = 18)) +
  annotation_scale(location = "tr", width_hint = 0.2) +
  annotation_north_arrow(location = "tr", which_north = "true", 
                         pad_x = unit(0.1, "in"), pad_y = unit(0.1, "in"),
                         style = north_arrow_fancy_orienteering)
bowmouth_map_colour

# Attempt to change shape and colour of points: first specify colours by Hex
#cols <- c("Sri_Lanka" = "#9523D6", "Bangladesh" = "#72F12F", 
#          "Saudi_Arabia" = "#FF198B", "Arabian_Peninsula" = "#4653FA")
#cols

# Code for colours
#geom_point(aes(color = factor(Region))) +
#  scale_colour_manual(values = cols)

#  geom_point(shape = 21, alpha = 0.5, size = 2) +
#  scale_colour_manual(
#    values = cols,
#    aesthetics = c("colour", "fill")

