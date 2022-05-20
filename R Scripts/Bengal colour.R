#Bengal guitarfish haplotype alignment colour
library(tidyr)
library(dplyr)

beng <- read.dna("Data/Bengal_guitarfish_Rannandalaei_Final.fasta", format = "fasta")

haps_beng <- haplotype(beng)

haps_beng_fish <-haploNet(haps_beng)

plot(haps_beng_fish, size = attr(haps_beng_fish, "freq"), fast = FALSE)

ind.hap_beng <- with(stack(setNames(
  attr(haps_beng, "index"), rownames(haps_beng)
)),
table(hap = ind, individuals = rownames(beng)[values]))
ind.hap_beng

df_beng <- as.data.frame(ind.hap_beng)
df_beng

clean_beng <- df_beng[df_beng$Freq == 1, ]
clean_beng

# clean up data frame and mutate to usable titles
df_beng2 <- clean_beng %>%
  mutate(new_name = gsub("\\s.+", "", individuals)) %>%
  separate(new_name, c("ID", "POP", "region")) %>%
  select(-region) %>%
  mutate(POP = case_when(
    POP == "Sri" ~ "SriLanka",
    POP == "Bangladesh" ~ "Bangladesh",
    TRUE ~ POP
  ))
df_beng2

locations_beng <- df_beng2$POP

new_hap_beng <- table(clean_beng$hap, locations)

#Colour plot haplotype 
plot(
  haps_beng_fish,
  size = attr(haps_beng_fish, "freq"),
  scale.ratio = 3,
  cex = 1,
  pie = ind.hap_beng
)

legend("topright",
       c("Bangladesh", "Sri Lanka"),
       text.col = 2:5)


png("Figures/hap_net_bg_CR.png")
plot(haps_bg_cr,
     size = attr(haps_bg_cr, "freq"),
     fast = FALSE)
dev.off()