# Calculating haplotype number and haplotype diversity: from Research gate

install.packages("haplotypes")
library(haplotypes)

#read your fasta file
bg_1 <- read.fas("Data/fasta_files/Bowmouth_FishF2R2_Final.fasta")

#this is your sequences
as.matrix(bg_1)

#infer haplotypes
h <- haplotypes::haplotype(bg_1,indels="m")
h

# length(h) gives the total number of haplotypes #
length(h)

#no direct method is available for calculating haplotype diversity in the current R version. However you can calculate it as follows:
#suppose 'pops' gives the populations where samples are collected.

pops_bg1 <- c("SriLanka","Bangladesh","SaudiArabia","ArabianPeninsula")
pops_bg1

group_bg_1 <- grouping(h, pops_bg1)
group_bg_1

sz_bg_1 <- apply(group_bg_1$hapmat,2,sum)
sz_bg_1

# hdiv gives the total haplotype diversity #
hdiv <- (sum(sz_bg_1)/(sum(sz_bg_1)-1))*(1-sum((sz_bg_1/sum(sz_bg_1))^2))
hdiv
