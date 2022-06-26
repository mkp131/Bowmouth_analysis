# scatterpie map with zoomed in regions
sf_use_s2(FALSE)

# full haplotype map
bowmouth_hap_map_zoom <- world %>%
  ggplot() +
  geom_sf(data = world, fill = land_colour, size = 0.4) +
  geom_scatterpie(
    aes(x = Longitude,
        y = Latitude,
        r = `Sum of Haplotypes` ** 0.07 * 0.5),
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
  theme(
    panel.grid = element_line(colour = "transparent"),
    axis.title = element_blank(),
    axis.text = element_text(size = 10),
    legend.position = "none",
  ) +
  annotation_scale(location = "tr", width_hint = 0.2)
bowmouth_hap_map_zoom


# sri lanka haplotype map
sri_lanka <- world %>%
  ggplot() +
  geom_sf(data = world, fill = land_colour, size = 0.4) +
  geom_scatterpie(
    aes(x = Longitude,
        y = Latitude,
        r = `Sum of Haplotypes` ** 0 * 0.4),
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
    x = 65,
    y = 12.5,
    label = "Arabian Sea",
    fontface = "italic",
    color = "grey22",
    size = 6
  ) +
  coord_sf(xlim = c(78.8, 82.5),
           ylim =
             c(10.7, 5.5),
           expand = FALSE) +
  mytheme +
  theme(
    panel.grid = element_line(colour = "transparent"),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    legend.text = element_text(size = 10),
    legend.title = element_text(size = 14),
    legend.position = "none",
  )
sri_lanka

ggsave("Figures/GIS_maps/sri_lanka_hap.pdf", width = 10, height = 7)
dev.off()


# bangladesh haplotype map
bangladesh <- world %>%
  ggplot() +
  geom_sf(data = world, fill = land_colour, size = 0.4) +
  geom_scatterpie(
    aes(x = Longitude,
        y = Latitude,
        r = `Sum of Haplotypes` ** 0 * 0.4),
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
    x = 65,
    y = 12.5,
    label = "Arabian Sea",
    fontface = "italic",
    color = "grey22",
    size = 6
  ) +
  coord_sf(xlim = c(90, 93),
           ylim =
             c(23, 20.5),
           expand = FALSE) +
  mytheme +
  theme(
    panel.grid = element_line(colour = "transparent"),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    legend.text = element_text(size = 10),
    legend.title = element_text(size = 14),
    legend.position = "none",
  )
bangladesh

ggsave("Figures/GIS_maps/bangladesh_hap.pdf", width = 10, height = 7)
dev.off()


# arabian peninsula incl saudi arabia samples haplotype map
arabian_pen <- world %>%
  ggplot() +
  geom_sf(data = world, fill = land_colour, size = 0.4) +
  geom_scatterpie(
    aes(x = Longitude,
        y = Latitude,
        r = `Sum of Haplotypes` ** 0 * 0.35),
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
    x = 65,
    y = 12.5,
    label = "Arabian Sea",
    fontface = "italic",
    color = "grey22",
    size = 6
  ) +
  coord_sf(xlim = c(53, 58),
           ylim =
             c(26.5, 16.5),
           expand = FALSE) +
  mytheme +
  theme(
    panel.grid = element_line(colour = "transparent"),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 18)
  )
arabian_pen

ggsave("Figures/GIS_maps/arabian_pen_hap_full.pdf", width = 10, height = 7)
dev.off()


# zoomed in further to east arabian peninsula 
arabian_pen_zoom <- world %>%
  ggplot() +
  geom_sf(data = world, fill = land_colour, size = 0.4) +
  geom_scatterpie(
    aes(x = Longitude,
        y = Latitude,
        r = `Sum of Haplotypes` ** 0 * 0.12),
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
    x = 65,
    y = 12.5,
    label = "Arabian Sea",
    fontface = "italic",
    color = "grey22",
    size = 6
  ) +
  coord_sf(xlim = c(53, 57),
           ylim =
             c(26, 24.25),
           expand = FALSE) +
  mytheme +
  theme(
    panel.grid = element_line(colour = "transparent"),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 18)
  ) 
arabian_pen_zoom

ggsave("Figures/GIS_maps/arabian_pen_hap_map.pdf", width = 10, height = 7)
dev.off()


# combined map - makes inset maps quite small
combined_map <- ggplot() +
  coord_equal(xlim = c(0, 28),
              ylim = c(0, 20),
              expand = FALSE) +
  annotation_custom(
    ggplotGrob(bowmouth_hap_map_zoom),
    xmin = 0,
    xmax = 20,
    ymin = 0,
    ymax = 20
  ) +
  annotation_custom(
    ggplotGrob(sri_lanka_bang),
    xmin = 20,
    xmax = 28,
    ymin = 11.25,
    ymax = 19
  ) +
  annotation_custom(
    ggplotGrob(arabian_pen_sa),
    xmin = 20,
    xmax = 28,
    ymin = 2.5,
    ymax = 10.25
  ) +
  theme_void()
combined_map
