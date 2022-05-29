install.packages("spider")
install.packages("HACSim")
library(spider)
library(HACSim)

## Simulate hypothetical species for Bowmouth guitarfish COI##

N <- 200 # total number of sampled individuals (can be guess, doesn't need to be actual)
Hstar <- 10 # total number of haplotypes
probs <- rep(1/Hstar, Hstar) # equal haplotype frequency distribution

# outputs a CSV file called "output.csv"
HACSObj <- HACHypothetical(N = N, Hstar = Hstar, probs = probs, 
                           filename = "output")

## Simulate hypothetical species - subsampling ##
# subsamples 25% of haplotype labels
HACSObj <- HACHypothetical(N = N, Hstar = Hstar, probs = probs, 
                           perms = 1000, p = 0.95, subsample = TRUE, 
                           prop = 1, 
                           conf.level = 0.95, filename = "output")

## Simulate hypothetical species and all paramaters changed - subsampling ##
HACSObj <- HACHypothetical(N = N, Hstar = Hstar, probs = probs, 
                           perms = 10000, p = 0.90, subsample = TRUE, 
                           prop = 0.15, conf.level = 0.95, 
                           num.iters = 1, filename = "output")
HACSObj

# Runs a simulation
HAC.simrep(HACSObj)

#Extract simulation parameters of interest
envr$
  
## Simulate real species ## 
# outputs file called "output.csv"
HACSObj <- HACReal(filename = "output")

## Simulate real species - subsampling ## 25% recovery (prop)
#HACSObj <- HACReal(subsample = TRUE, prop = 0.25, conf.level = 0.95, 
#                   p = 0.95, filename = "output", perms = 10000)

## Simulate real species - subsampling ## 95% recovery (prop)
HACSObj <- HACReal(conf.level = 0.95, p = 0.95,
                   filename = "output", perms = 10000)

## Simulate real species and all parameters changed - subsampling ##
#HACSObj <- HACReal(perms = 10000, p = 0.90, subsample = TRUE, 
#                   prop = 0.15, conf.level = 0.99, filename = "output")

# user prompted to select appropriate FASTA file
HAC.simrep(HACSObj)




## Simulate hypothetical species for Bowmouth guitarfish CR##

N <- 200 # total number of sampled individuals
Hstar <- 3 # total number of haplotypes
probs <- rep(1/Hstar, Hstar) # equal haplotype frequency distribution

# outputs a CSV file called "output.csv"
HACSObj <- HACHypothetical(N = N, Hstar = Hstar, probs = probs, 
                           filename = "output")

## Simulate hypothetical species - subsampling ##
# subsamples 25% of haplotype labels
HACSObj <- HACHypothetical(N = N, Hstar = Hstar, probs = probs, 
                           perms = 10000, p = 0.95, subsample = TRUE, prop = 0.95, 
                           conf.level = 0.95, filename = "output")

## Simulate hypothetical species and all paramaters changed - subsampling ##
HACSObj <- HACHypothetical(N = N, Hstar = Hstar, probs = probs, 
                           perms = 10000, p = 0.90, subsample = TRUE, prop = 0.15, conf.level = 0.95, 
                           num.iters = 1, filename = "output")
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



