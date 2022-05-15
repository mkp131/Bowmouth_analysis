#Bowmouth guitarfish CR alignment colour
bg_cr <- read.dna("Data/Bowmouth_CR_Alignment_tidy.fasta", format = "fasta")
bg_cr

haps_cr <- haplotype(bg_cr)
haps_cr

haps_bg_cr <- haploNet(haps_cr)

plot(haps_bg_cr, size = attr(haps_bg_cr, "freq"), fast = FALSE)

ind.hap_bg_cr <- with(
  stack(setNames(attr(haps_cr, "index"), rownames(haps_cr))),
  table(hap=ind, individuals=rownames(bg_cr)[values])
)

ind.hap_bg_cr


library(tidyr)
library(dplyr)

df_bg_cr <- as.data.frame(ind.hap_bg_cr)
df_bg_cr

clean_bg_cr <- df_bg_cr[df_bg_cr$Freq == 1,]
clean_bg_cr

# clean up data frame and mutate to usable titles
df <- clean_bg_cr %>%
  mutate(new_name = gsub("\\s.+", "", individuals)) %>%
  separate(new_name, c("ID", "POP", "region")) %>%
  select(-region) %>%
  mutate(POP = case_when(POP == "Sri" ~ "SriLanka",
                         POP == "Saudi" ~ "SaudiArabia",
                         POP == "Arabian" ~ "ArabianPeninsula",
                         TRUE ~ POP))
df

locations <- df$POP
locations
 
new_hap <- table(clean_bg_cr$hap, locations)
new_hap

png("Figures/haps_bg_cr.png")

plot(
  haps_bg_cr,
  size = attr(haps_bg_cr, "freq"),
  scale.ratio = 3,
  cex = 1,
  pie = new_hap
)

legend(
  "bottomleft",
  c("ArabianPeninsua", "Bangladesh", "SriLanka", "SaudiArabia"),
  text.col = 2:5
)
dev.off()



plot(
  haps_bg_cr,
  size = attr(haps_bg_cr, "freq"),
  scale.ratio = 3,
  cex = 1,
  pie = ind.hap_bg_cr
)

legend(
  "topright",
  c("Bangladesh", "Sri Lanka", "Arabian Peninsula"),
  text.col = 2:5
)

png("Figures/hap_net_bg_CR.png")
plot(haps_bg_cr, size = attr(haps_bg_cr, "freq"), fast = FALSE)
dev.off()


