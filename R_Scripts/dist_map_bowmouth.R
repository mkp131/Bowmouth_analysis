# Install and load packages
#install.packages("maptools")
#install.packages("leaflet")
#install.packages("rgdal")
#install.packages("scatterpie")
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

# Overlay shp file on my map
bowmouth_map_colour <- world %>%
  ggplot() +
  geom_sf(data = world, fill = land_colour, size = 0.4) +
  geom_polygon(
    aes(x = long, y = lat, group = group),
    fill = 'lightslateblue',
    size = 0.2,
    colour = 'lightslateblue',
    data = bg_shp_df,
    alpha = 0.5
  ) +
  annotate(
    geom = "text",
    x = 62,
    y = 12.5,
    label = "Arabian
  Sea",
    fontface = "italic",
    color = "grey22",
    size = 4
  ) +
  annotate(
    geom = "text",
    x = 80,
    y = -20,
    label = "Indian Ocean",
    fontface = "italic",
    color = "grey22",
    size = 7
  ) +coord_sf(
    xlim = c(4.946053, 171.9984143),
    ylim =
      c(49.019859, -46.4214183),
    expand = FALSE
  ) +
  mytheme +
  labs(x = "Longitude",
       y = "Latitude",
       fill = "",
       title = "Bowmouth Guitarfish Distribution Map") +
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
    pad_x = unit(0.3, "in"),
    pad_y = unit(0.3, "in"),
    style = north_arrow_fancy_orienteering
  )
bowmouth_map_colour

# Save figure

ggsave("Figures/GIS_maps/Dist_map_bowmouth.pdf", width = 10, height = 7)
dev.off()
