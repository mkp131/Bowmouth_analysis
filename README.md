# Bowmouth Analysis

This project is part of the data analysis for my dissertation in Bowmouth guitarfish for a MVetSci in Conservation Medicine at the University of Edinburgh. 
This also contains the code used for the analyses and figures in the following manuscript:
"Population structure and genetic diversity of the Critically Endangered bowmouth guitarfish (Rhina ancylostomus) in the Northwest Indian Ocean" (by Marja J. Kipperman, Rima W. Jabado, Alifa Bintha Haque, Daniel Fernando, P.A.D.L Anjani, Julia L.Y. Spaet, Emily Humble)

Preprint: https://www.biorxiv.org/content/10.1101/2024.03.15.585225v3
Peer reviewed and recommended by PCI in Evolutionary Biology: https://evolbiol.peercommunityin.org/articles/rec?id=792

I have used R for most of my analyses. 

Things to note:
- Rscripts: contains the R scripts of each analyses I wanted to achieve
- I have removed access to my data files as they contain sensitive information. If you want to follow the script you would need to add in your own data files in the format suggested in the script (mainly fasta files)
- most of my alignments have been created in the software Geneious and exported as a fasta file
-for any of the map scripts the original GIS map script contains the elements in the Rstudio environment that would be required to run that code, in particular 'world', 'theme' which are needed for the other map scripts. 
- some scripts were not used for the dissertation, but were used to increase my understanding, such as hap.nets to build a haplotype network, which I used PopART software for in the end. 
