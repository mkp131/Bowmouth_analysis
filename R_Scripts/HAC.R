install.packages("spider")
install.packages("HACSim")
library(spider)
library(HACSim)

## Bowmouth guitarfish COI

N <- 200 # total number of sampled individuals (can be estimate, doesn't need to be actual)
Hstar <- 10 # total number of haplotypes found in data set
probs <- rep(1/Hstar, Hstar) # equal haplotype frequency distribution
  
## Simulate real species ## 
# outputs file called "output.csv"
HACSObj <- HACReal(filename = "output")

## Simulate real species - subsampling ## 95% recovery (prop)
# can rerun at p = 0.99 (for 99% recovery, p = 0.85% for 85% etc)
HACSObj_bow <- HACReal(conf.level = 0.95, p = 0.95,
                   filename = "output", perms = 10000)

# user prompted to select appropriate FASTA file
HAC.simrep(HACSObj_bow)

##  Bowmouth guitarfish CR##

N <- 200 # total number of sampled individuals
Hstar <- 3 # total number of haplotypes
probs <- rep(1/Hstar, Hstar) # equal haplotype frequency distribution

HACSObj

# Runs a simulation
HAC.simrep(HACSObj)

#Extract simulation parameters of interest
envr$
  
## Simulate real species ## 
# outputs file called "output.csv"
HACSObj <- HACReal(filename = "output")

## Simulate real species - subsampling ## 95%
HACSObj <- HACReal(subsample = TRUE, prop = 0.95, conf.level = 0.95, 
                   filename = "output")

## Simulate real species and all parameters changed - subsampling ##
HACSObj <- HACReal(perms = 10000, p = 0.90, subsample = TRUE, 
                   prop = 0.15, conf.level = 0.99, filename = "output")

# user prompted to select appropriate FASTA file
HAC.simrep(HACSObj)
