# Script to look at haplotypes

# install.packages("ape")
# install.packages("pegas")

# load packages

library(ape)
library(pegas)

#import fasta file
bg <- read.dna("Data/Cr_a_test_alignment.fasta", format = "fasta")
#extracts haplotypes from sequences
haps <- haplotype(bg)

#create haplotype network
haps_bg <- haploNet(haps)

plot(haps_bg, size = attr(haps_bg, "freq"), fast = FALSE)

# Save figure
png("Figures/hap_net.png")
plot(haps_bg, size = attr(haps_bg, "freq"), fast = FALSE)
dev.off()


