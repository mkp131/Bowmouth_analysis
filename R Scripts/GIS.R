# Install packages
install.packages(c("tidyverse", "rnaturalearthhires", "sf", "ggplot2", "ggrepel",
                   'rnaturalearth'))
install.packages("rnaturalearthhires")
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

# Create a basic world map: this selects data column that has coordinates for the 
# countries and sf package for spatial data
world %>% ggplot() + geom_sf()

# Can define aesthetics using aes function
world %>% ggplot() + 
  geom_sf(color = "black", fill = "purple")

# Can fill map by assigning fill argument inside the aesthetics such as GDP data
world %>% ggplot() + 
  geom_sf(color = "black", aes(fill = gdp_md_est))

# Narrow down to certain region: By adding the coord_sf() layer with the arguments xlim
# and ylim, we can zoom to any part. expand = FALSE ensures map boundaries are cut off at 
# defined coordinates and no buffer space is provided. Coordinates listed as xlim Longitude
# and longitude, then ylim, latitude and latitude of boundaries
world %>% ggplot() +
  geom_sf() +
  coord_sf(xlim = c(88.594382881345, 152.93774260658), ylim =  
             c(31.29186472309,-12.375471986864), expand = FALSE)

# With my region coordinates: Dubai to Bangladesh
world %>% ggplot() +
  geom_sf() +
  coord_sf(xlim = c(23.94462692660258, 100.25850522440837), ylim =  
             c(40.350447135475605, 3.1895747788411266), expand = FALSE)

# Try fill in countries according to their populations (pop_est), 1st way to do this
# is to float the map where only SE Asia is highlighted
world %>% filter(subregion == "South-Eastern Asia") %>% 
  select(name,geometry,pop_est) %>%
  ggplot() +
  geom_sf(color="black", aes(fill = pop_est)) +
  coord_sf(xlim = c(88.594382881345, 152.93774260658), 
           ylim = c(31.29186472309,-12.375471986864), expand = FALSE)

# Or we can retain bordering countries like this 2nd method
SE_Asia <- world %>% filter(subregion == "South-Eastern Asia") %>% 
  select(name,subunit,geometry,pop_est)
(SEA_map <- world %>% 
    ggplot() +
    geom_sf() +
    geom_sf(data=SE_Asia, aes(fill=pop_est),color="black") +
    coord_sf(xlim = c(88.594382881345, 152.93774260658), 
             ylim = c(31.29186472309,-12.375471986864), expand = FALSE))

# rnaturalearth does not have data for cities but we can load maps package
install.packages("maps")
library(maps)
head(world.cities)
class(world.cities)

# Load csv file containing coordinates
wedge_coord <- read_csv("Data/GPS_coord_for_R - Sheet1.csv")
spec(wedge_coord)
wedge_coord_1 = wedge_coord[, c(4, 5)]
print(wedge_coord_1)
                        
# convert to sf (simple features) function
bowmouth_sf <- st_as_sf(wedge_coord_1, coords = c("Longitude", "Latitude"), crs = 4326)
bowmouth_sf

#?? geom_sf(data = bowmouth_sf, aes(fill = "blue"), color = "black") 

# Plot coordinates on previous map
bowmouth_map <- world %>% 
  ggplot() +
  geom_sf() +
  geom_point(data = wedge_coord_1, aes(x = Longitude, y = Latitude,
                                       size = Value), 
             colour="Dark Blue", fill="Blue",pch = 21, size = 2, 
             alpha = I(0.7)) +
  coord_sf(xlim = c(23.94462692660258, 100.25850522440837), ylim =  
             c(40.350447135475605, 3.1895747788411266), expand = FALSE)
bowmouth_map


# MK changing theme (external tutorial) to change land colour and ocean colour
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

bowmouth_map_colour <- world %>% 
  ggplot() +
  geom_sf(data = world, fill = land_colour, size = 0.4) +
  geom_point(data = wedge_coord_1, aes(x = Longitude, y = Latitude, size = Value), 
             colour="Dark Blue", fill="Blue",pch = 21, size = 2, alpha = I(0.7)) +
  coord_sf(xlim = c(23.94462692660258, 100.25850522440837), ylim =  
             c(40.350447135475605, 3.1895747788411266), expand = FALSE) +
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
                         pad_x = unit(0.2, "in"), pad_y = unit(0.3, "in"),
                         style = north_arrow_fancy_orienteering)
bowmouth_map_colour

# extract capitals of SEAsia and assign to capital, we filter countries using the %in% 
# function to check the overlapping countries and filter only the cities for which the
# capital is assigned the value of 1
capital <- world.cities %>% 
  filter(country.etc %in% SE_Asia$subunit, capital == 1)
capital

#Plot these cities
SEA_map + 
  geom_point(data=capital, aes(long, lat), size = 2, color="red")

# converting to sf object, st_as_sf converts the coordinates to sf object
# we need to identify which columns are the coordinates that need to be converted and
# the coordinate reference system (crs) crs = 4326 is the most commonly used code by 
# organisations that provide GIS data

capital <- st_as_sf(capital, coords = c("long", "lat"), crs = 4326)
(SE_Asia_map <- world %>% 
    ggplot() +
    geom_sf() +
    geom_sf(data = SE_Asia, aes(fill = pop_est),color = "black") +
    geom_sf(data = capital, size = 2, color = "red") +
    coord_sf(xlim = c(88.594382881345, 152.93774260658), 
             ylim = c(31.29186472309,-12.375471986864), expand = FALSE))

# Add labels,scale bar and compass
# the geospatial data for the borders of the country are multipolygon, so we need
# to find a single coordinate to label the country names. Thi can be done by calculatin
# the centroid of the countries st_centroid() function from sf package
SEA_centroid <- st_centroid(world %>% 
                              filter(subregion == "South-Eastern Asia") %>% 
                              select(name))

# Add scale bar and compass, ggspatial package. the annotation_scale adds the scale bar, 
# the argument location is set to tr (=top right) the width_hint defines the width of the
# bar. The annotation_north_arrow() uses location as an argument. You can fine tune using
# pad_x and pad_y. If the argument which_north is true then the compass always points 
# towards the north pole
library(ggspatial)
SEA_centroid <- st_centroid(world %>% 
                              filter(subregion == "South-Eastern Asia") %>% 
                              select(name))
annotation_scale(location = "tr", width_hint = 0.5) +
  annotation_north_arrow(location = "tr", which_north = "true", 
                         pad_x = unit(0.3, "in"), pad_y = unit(0.5, "in"),
                         style = north_arrow_fancy_orienteering)

# Final Map
world %>% 
  ggplot() +
  geom_sf() +
  geom_sf(data=SE_Asia, aes(fill=pop_est),color="black") +
  # adding capital cities as points
  geom_sf(data=capital, size = 2, color = "red") +
  # adding labels
  geom_sf_label(data=SEA_centroid,aes(label=name),
                nudge_x = c(1,-5.5,2,2,-1,-2,2.5,1,-7,1,4), 
                nudge_y = c(3.5,-8,1.5,5.5,2.5,1.5,6,-1.75,-0.5,2.5,1.5)) +
  # setting the limits for South East Asia region
  coord_sf(xlim = c(88.594382881345, 152.93774260658),
           ylim = c(31.29186472309,-12.375471986864), expand = FALSE) +
  # adding scale and compass
  annotation_scale(location = "tr", width_hint = 0.5) +
  annotation_north_arrow(location = "tr", which_north = "true", 
                         pad_x = unit(0.3, "in"), pad_y = unit(0.5, "in"),
                         style = north_arrow_fancy_orienteering) +
  # adding color the waters and other aesthetics
  theme(panel.background = element_rect(fill = "aliceblue")) + 
  xlab("") + ylab("") +
  guides(fill = guide_colourbar(label = FALSE))+
  scale_fill_viridis_b() +
  labs(fill = "Population")
