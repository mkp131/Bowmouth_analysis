# Prepare to install Bioconductor packages
#if (!requireNamespace("BiocManager", quietly = TRUE))
# install.packages("BiocManager")

# Install bioconductor packages

#BiocManager::install(c("msa"))
#BiocManager::install(c("Biostrings"))
#BiocManager::install(c("ggtree"))

# Install CRAN packages

#install.packages("ips")
#install.packages("kableExtra")

# Load packages

library(Biostrings)
library(msa)
library(ips)
library(kableExtra)
library(dplyr)
library(ggplot2)
library(phangorn)
library(ggtree)

# Load the Load Alignment function

source("load_alignment.R")

#~~ Read in alignment

seq <- readDNAStringSet("Data/fasta_files/Tree_alignment_FINAL.fasta", format="fasta")

# Alignment, align and trim
# align = T if you need to align and trim your sequences, F if not

dna_bin <- LoadAlignment(seq, align = T)

dna_bin

# Visualise alignment

ape::image.DNAbin(dna_bin, col = c("#CB2314", "#FAD510", "#4daf4a", "#5BBCD6", "grey", "black"))

# Convert the DNAbin object into phyDat

phy <- phangorn::phyDat(dna_bin, type = "DNA")

# Run the model testing for phylogeny

tree <- NJ(dist.ml(phy))
allmodels <- phangorn::modelTest(phy, model = "all", G = TRUE, I = FALSE, 
                                 tree = tree, multicore = FALSE)

# Using only the available models when making a neighbour-joining tree as not all 
# models that were tested are available to make a tree.

available <- c("JC", "JC+G","K80", "K80+G", "F81", "F81+G","K81", "K81+G")
availablemodels <- allmodels[allmodels$Model %in% available,]

# Selecting the model with the lowest BIC
optimalmodel <- availablemodels[which.min(availablemodels$BIC),1]
optimalmodel

# Selecting the nucleotide substitution portion
model <- strsplit(optimalmodel, "[+]")[[1]][1]

# Indicating whether we are using gamma distributed rates
gamma <- strsplit(optimalmodel, "[+]")[[1]][2] == "G"


# Now to make a neighbour-joining tree

# Making a distance matrix
d <- ape::dist.dna(dna_bin, model = model, gamma = gamma)

# Now to make the tree
tree <- ape::bionj(d)
tree
  
# Selecting the outgroup sequence. NB: make sure outgroup sequence is last in the alignment file

seqnames <- names(as.list(dna_bin))

# Number of sequences
n <- length(seqnames)

# Select the last sequence (i.e. the outgroup)
outgroup <- seqnames[n]
  
# Now root the tree with the outgroup
tree <- ape::root(tree, outgroup = outgroup, resolve.root = TRUE)
  
# Bootstrapping
bootstraps <- 1000

boot <- ape::boot.phylo(phy = tree, dna_bin, B = bootstraps,  
                        function(d) root(bionj(dist.dna(d, model = model, gamma = gamma)), 
                                         outgroup = outgroup))


tree$node.labels <- boot/bootstraps
tree$node.labels 

#~ Plot tree

tree$tip.label

p <- ggtree(tree) + geom_text(aes(label=node), size = 3, hjust = 1, vjust = 1)
p

meta <- as.data.frame(tree$tip.label) %>%
  rename("taxa" = `tree$tip.label`) %>%
  mutate(species = gsub(".+\\(", "", taxa)) %>%
  mutate(species = gsub("\\)", "", species))
meta

sp <- levels(as.factor(meta$species))
sp

# if we want to use regional information
#levels(meta$region)
#meta$region <- factor(meta$region, levels(meta$region)[c(1,2,5,3,4)])
#loc <- levels(meta$region)

#~~ Specific colour palette

pal <- c("#e41a1c", # red
         "#046C9A", # blue
         "#ae017e", #  pink
         "goldenrod",   #  yellow
         "#984ea3", #  purple
         "#1d91c0", #  light blue
         "#35978f", #  dark turquoise
         "#a65628", #  brown
         "lightseagreen", #  turquoise
         "#1b7837", #  dark green
         "#ff7f00")

#~~ Plot tree with species colour coded

p <- ggtree(tree, color = "black", size = 0.4) %<+% meta + 
  #geom_tippoint(aes(color=species)) 
  geom_tiplab(size = 2, aes(color = species)) +
  scale_color_manual(breaks = sp,
                    values = pal,
                    labels = c("*G.granulatus*",
                               "*R.ancylostoma*",
                               "*R.annandalei*",
                               "*R.australiae*",
                               "*R.jayakari*",
                               "*R.lionotus*",
                               "*R.palpebratus*",
                               "*R.variegatus*"),
                    name = "Species", guide = "none") +
  xlim(0, 0.25)

p

# Get bootstrap support values >95%

d <- p$data
d <- d[!d$isTip,]
d$label <- as.numeric(d$label)
d <- d[d$label > 0.95,]

#~~ Add bootstrap support to tree

# Plot nodes onto phylogeny when bootstrap support > 95%

p <- p + 
  geom_nodepoint(data = d, size = 3, shape = 21, fill = "white")
  #geom_nodelab(data = d, hjust= 2)

p

# Save figure

ggsave("Figures/Species_Phylogeny.png", height = 7, width = 9)

