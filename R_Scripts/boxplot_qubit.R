install.packages('ggforce')
install.packages("patchwork")
library(patchwork)
library(ggforce)
library(tidyverse)

qubit_bow <- read_csv("csv_files_for_r/Qubit_bow.csv")
head(qubit_bow)
qubit_bow_val = qubit_bow[c(1,3,5)]
print(qubit_bow_val)

#Make bowmouth boxplot of data with jitter so points dont overlap
bow_boxplot <- qubit_bow_val %>%
  ggplot(aes(x = Species, y = `Qubit (ng/µl)`, fill = Region))  +
  geom_boxplot(outlier.shape = NA) +
  scale_fill_manual(values = c("#4653FA", "#72F12F", "#FF198B", "#9523D6")) +
  geom_point(
    pch = 21,
    position = position_jitterdodge(
      jitter.width = 0.1,
      jitter.height = 0.15,
      dodge.width = 0.75,
      seed = 42
    )) +
      labs(subtitle = "Qubit concentrations by Region") +
      theme_classic() +
  theme(axis.title.x = element_blank())
    #theme(legend.position = "None", axis.title.x = element_blank())
bow_boxplot

ggsave("Bowmouth_quibit_plot.pdf")



# make rhino rays qubit boxplot
qubit_rhino <- read_csv("Data/csv_files_for_r/Qubit_rhinoray.csv")
head(qubit_rhino)
qubit_rhino_val = qubit_rhino[c(1,3,5)]
print(qubit_rhino_val)

#Make boxplot of data with jitter so points dont overlap
rhinoray_boxplot <- qubit_rhino_val %>%
  ggplot(aes(x = Species, y = `Qubit (ng/µl)`, fill = Region)) +
  geom_boxplot(outlier.shape = NA, width = 0.6) +
  scale_fill_manual(
    values = c(
      "turquoise",
      "#72F12F",
      "yellow",
      "#9523D6")
  ) +
  geom_point(
    pch = 21,
    position = position_jitterdodge(
      jitter.width = 0.1,
      jitter.height = 0.15,
      dodge.width = 0.75,
      seed = 42
    )
  ) +
  labs(subtitle = "Rhino ray Qubit concentrations by Region") +
  theme_classic() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, margin = margin(r = 0)),
    axis.title.x = element_blank()
  )

rhinoray_boxplot

ggsave("Rhino_ray_quibit_plot_colours.pdf")

# Combine boxplots so side by side
bow_boxplot + rhinoray_boxplot

ggsave("Qubit_boxplots.pdf")
  