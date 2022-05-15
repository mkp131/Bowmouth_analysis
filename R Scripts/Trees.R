# Install and load packages and read in an alignment

install.packages("phangorn")
install.packages("ape")
install.packages("pegas")

library(pegas)
library(ape)
library(phangorn)

wedgefish <- read.dna("Data/Species_alignment_Tree1.fasta", format = "fasta")
fdir <- system.file("extdata/trees", package = "phangorn")
rhino <- read.phyDat(file.path(fdir, "read.dna"),
                        format = "interleaved")

# Generate tree using distance based methods
dm  <- dist.ml(primates)
treeUPGMA  <- upgma(dm)
treeNJ  <- NJ(dm)