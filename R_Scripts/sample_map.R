# Install packages
install.packages(c(
  "tidyverse",
  "rnaturalearthhires",
  "sf",
  "ggplot2",
  "ggrepel",
  'rnaturalearth'
))

install.packages("rnaturalearthhires")
# if cant load above then use 
#install.packages("devtools")
#library(devtools)
#devtools::install_github("ropensci/rnaturalearthhires")


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
library(rnaturalearthdata)
library(viridisLite)
library(ggspatial)

# Set dark-on-light theme for maps
theme_set(theme_light())

#rnaturalearth provides world map, ne_countries pulls country data
world <- ne_countries(scale = "medium", returnclass = "sf")

# Class of  world will show us class and the column names
class(world)

# Load csv file containing coordinates
wedge_coord <-
  read_csv("Data/GPS_coord_for_R_bowmouth - consolidated.csv")
spec(wedge_coord)
wedge_coord_1 = wedge_coord[, c(1, 3, 4, 7, 8)]
print(wedge_coord_1)

# st_as_sf converts coords (coord ref system crs = 4326 (for GIS data)

bowmouth_sf <- st_as_sf(wedge_coord_1,
                        coords = c("Longitude", "Latitude"),
                        crs = 4326)
bowmouth_sf

# changing theme to change land colour and ocean colour
mytheme <- theme(
  text = element_text(family = 'Avenir'),
  panel.grid.major = element_line(
    color = '#cccccc',
    linetype = 'dashed',
    size = .3
  ),
  panel.background = element_rect(fill = 'aliceblue'),
  plot.title = element_text(size = 32),
  plot.subtitle = element_text(size = 14),
  axis.title = element_blank(),
  axis.text = element_text(size = 10)
  )
  land_colour <- c('antiquewhite1')

# ggspatial adds scale bar and compass, location is set to tr (=top right)
# the width_hint defines bar width. 

# geom_text: hjust/nudge_x=horizontally, vjust/nudge_y=vertically
# ggrepelto move labels around so they dont overlap

#  coord_sf() layer and xlim and ylim zooms to region of choice
# With my region coordinates: Dubai to Bangladesh


# determine centroid of countries for labelling
geometries <- world$geometry
centroids <- st_centroid(geometries)
centroid_coords <- st_coordinates(centroids)
world_points <- cbind(world, centroid_coords)
world_points

# Chose colour scheme
cols <- c("Sri Lanka" = "#9523D6", "Bangladesh" = "#72F12F", 
          "Saudi Arabia" = "#FF198B", "Arabian Peninsula" = "#4653FA")


# Final Map: pch = point characteristics, element.text() alters font, size
bowmouth_map_colour <- world %>%
  ggplot() +
  geom_sf(data = world, fill = land_colour, size = 0.4) +
  geom_point(
    data = wedge_coord_1,
    mapping = aes(
      x = Longitude,
      y = Latitude,
      size = `Number of Samples`,
      fill = Region
    ),
    pch = 21,
    alpha = I(0.8)
  ) +
  scale_fill_manual(values = cols,
                    name = "Sampling Location") +
  annotate(
    geom = "text",
    x = 65,
    y = 12.5,
    label = "Arabian Sea",
    fontface = "italic",
    color = "grey22",
    size = 6
  ) +
  coord_sf(
    xlim = c(35.94462692660258, 95.25850522440837),
    ylim =
      c(32.350447135475605, 5.1895747788411266),
    expand = FALSE
  ) +
  mytheme +
  labs(x = "Longitude",
       y = "Latitude",
       fill = "",
       title = "Bowmouth guitarfish landing sites") +
  theme(
    panel.grid = element_line(colour = "transparent"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.text = element_text(size = 10),
    legend.title = element_text(size = 14),
    plot.title = element_text(face = "bold", size = 18)
  ) +
  annotation_scale(location = "tr", width_hint = 0.2) +
  annotation_north_arrow(
    location = "tr",
    which_north = "true",
    pad_x = unit(0.2, "in"),
    pad_y = unit(0.3, "in"),
    style = north_arrow_fancy_orienteering
  )
bowmouth_map_colour

# save map, adjust figures till correct
ggsave("Figures/GIS_maps/bowmouth_map_colour.png",
       bowmouth_map_colour, units = "cm",
       width = 20, height = 10)


