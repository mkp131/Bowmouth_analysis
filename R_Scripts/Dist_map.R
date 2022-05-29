# Install and load packages
install.packages("maptools")
install.packages("leaflet")
library(maptools) # creates maps and work with spatial files
library(broom)    # assists with tidy data
library(ggplot2)  # graphics package
library(leaflet)  # interactive graphics (output does not show in RMD files)
library(dplyr)    # joining data frames
library(readr)    # quickly reads files into R

# Load shapefile
bowmouth_shp <- st_read("Figures/Bowmouth_dist_map_IUCN/data_0.shp")
bowmouth_shp
str(bowmouth_shp)

# plot shp file map
ggplot(bowmouth_shp) +
  geom_sf()
