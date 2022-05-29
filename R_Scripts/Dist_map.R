# Install and load packages
install.packages("maptools")
install.packages("leaflet")
install.packages("rgdal")
library(maptools) # creates maps and work with spatial files
library(broom)    # assists with tidy data
library(ggplot2)  # graphics package
library(leaflet)  # interactive graphics (output does not show in RMD files)
library(dplyr)    # joining data frames
library(readr)    # quickly reads files into R
library(sf)
library(rgdal)

# Load shapefile
bowmouth_shp <- st_read("Figures/Bowmouth_dist_map_IUCN/data_0.shp")
bowmouth_shp
str(bowmouth_shp)

# plot shp file map
ggplot(bowmouth_shp) +
  geom_sf()

# convert shp to df
bg_shp_df <- readOGR("Figures/Bowmouth_dist_map_IUCN/data_0.shp")
class(bg_shp_df)

geom_polygon(
  aes(x = long, y = lat, group = group),
  fill = 'grey',
  size = 0.5,
  colour = 'aquamarine',
  data = bg_shp_df,
  alpha = 0
)

# make colours transparent (gives  aquamarine "#0000FF7D" )
mycol_a <- rgb(0, 0, 255, max = 255, alpha = 125, names = "aquamarine")
mycol_a

# Overlay shp file on my map- error not zooomed in
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
  geom_polygon(
    aes(x = long, y = lat, group = group),
    fill = 'grey',
    size = 0.5,
    colour = '#0000FF7D',
    data = bg_shp_df,
    alpha = 0
  )
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
