install.packages("adegenet", dep=TRUE)
library("ape")
library("pegas")
library("seqinr")
library(ggplot2)
library("adegenet")

# Import data
bg_coi <- read.dna("Data/fasta_files/Bowmouth_FishF2R2_Final.fasta", format = "fasta")
bg_coi

class(bg_coi)

bg_coi <- as.matrix(bg_coi)

# snpposi.plot (plots SNP density along slignment) and snpposi.test (tests 
# whether these SNPS are randomly distributed) characterizes polymorphism
snpposi.plot(bg_coi,codon=FALSE) 
snpposi.plot(bg_coi)

# DNAbin2genind function allows one to specify a threshold for polymorphism. e.g.
# we could retain only SNPs for which the second largest allele frequency is 
# greater that 1% (using the polyThres argument):
obj_bg <- DNAbin2genind(bg_coi, polyThres=0.01)
obj_bg

# Positions of the SNPs are stored as names of the loci, the names of the loci
# directly provides the indices of polymorphic sites:
head(locNames(obj_bg))

# constructs a table of polymorphic sites, which converts into a genind object
table_bg_coi <- genind2df(obj_bg)
table_bg_coi

dim(table_bg_coi)
table(unlist(table_bg_coi))

# Protein distances used in seqinr package and phangorn package NOT WORKING??
myseqs_bg_coi <- read.alignment(file = system.file("Bowmouth_FishF2R2_Final.fasta",
                                            package = "seqinr"), format = "fasta")
dist.alignment(myseqs, matrix = "identity" )
as.matrix(dist.alignment(myseqs, matrix = "identity" ))

D_bg <- dist.alignment(obj_bg, matrix = c("identity", "similarity"),gap)
D >- dist(tab(obj_bg))
D

