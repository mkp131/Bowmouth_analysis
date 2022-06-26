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
library(scatterpie) # plots pie charts 

# Load csv file containing coordinates and haplotypes
wedge_coord_hap <-
  read_csv("Data/GPS_coord_for_R_bowmouth_hap_COI.csv")
spec(wedge_coord_hap)
wedge_coord_hap1 = wedge_coord_hap[, c(1, 2, 3, 6, 7, 8, 9,
                                       10, 11, 12, 13, 14, 15, 16)]
print(wedge_coord_hap1)

cols_haps <- c(
  "Haplotype 1" = "dodgerblue1",
  "Haplotype 2" = "darkblue",
  "Haplotype 3" = "cyan4",
  "Haplotype 4" = "darkorchid",
  "Haplotype 5" = "lawngreen",
  "Haplotype 6" = "red3",
  "Haplotype 7" = "saddlebrown",
  "Haplotype 8" = "hotpink",
  "Haplotype 9" = "seagreen2",
  "Haplotype 10" = "goldenrod"
)

print(cols_haps)

# construct pie charts of haplotypes
set.seed(123)

bowmouth_hap_map <- world %>%
  ggplot() +
  geom_sf(data = world, fill = land_colour, size = 0.4) +
  geom_scatterpie(
    aes(x = Longitude,
        y = Latitude,
        r = `Sum of Haplotypes` ** 0.07 * 0.7),
    data = wedge_coord_hap1,
    cols = c(
      "Haplotype 1",
      "Haplotype 2",
      "Haplotype 3",
      "Haplotype 4",
      "Haplotype 5",
      "Haplotype 6",
      "Haplotype 7",
      "Haplotype 8",
      "Haplotype 9",
      "Haplotype 10"
    ),
    alpha = 1
  ) +
  scale_fill_manual(values = cols_haps,
                  name = "Haplotypes") +
  annotate(
    geom = "text",
    x = 63,
    y = 12.5,
    label = "Arabian Sea",
    fontface = "italic",
    color = "grey22",
    size = 5
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
       title = "Bowmouth Guitarfish Haplotype Locations") +
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
    pad_x = unit(0.1, "in"),
    pad_y = unit(0.2, "in"),
    style = north_arrow_fancy_orienteering
  )
bowmouth_hap_map

ggsave("Figures/GIS_maps/hap_map_bowmouth.pdf", width = 10, height = 7)
dev.off()


