#Bowmouth guitarfish CR alignment
bg_cr <- read.dna("Data/fasta_files/Bowmouth_CR_Alignment_tidy.fasta", format = "fasta")
haps_cr <- haplotype(bg_cr)
haps_bg_cr <-haploNet(haps_cr)
plot(haps_bg_cr, size = attr(haps_bg_cr, "freq"), fast = FALSE)
png("Figures/hap_net_bg_CR.png")
plot(haps_bg_cr, size = attr(haps_bg_cr, "freq"), fast = FALSE)
dev.off()

#Bowmouth guitarfish initial alignment Fish F2 R2
bg <- read.dna("Data/fasta_files/Bowmouth_FishF2R2_Final.fasta", format = "fasta")
haps <- haplotype(bg)
haps_bg <-haploNet(haps)
plot(haps_bg, size = attr(haps_bg, "freq"), fast = FALSE)
png("Figures/hap_net_bg.png")
plot(haps_bg, size = attr(haps_bg, "freq"), fast = FALSE)
dev.off()

#Smoothback guitarfish
sg <- read.dna("Data/Smoothback_guitarfish_R_lionotus.fasta", format = "fasta")
haps_sg <- haplotype(sg)
haps_sg_fish <-haploNet(haps_sg)
plot(haps_sg_fish, size = attr(haps_sg_fish, "freq"), fast = FALSE)
png("Figures/hap_net_sg.png")
plot(haps_sg_fish, size = attr(haps_sg_fish, "freq"), fast = FALSE)
dev.off()

#Bottlenose wedgefish
bw <- read.dna("Data/Bottlenose_wedgefish_R.australiae_corrected.fasta", format = "fasta")
haps_bw <- haplotype(bw)
haps_bw_fish <-haploNet(haps_bw)
plot(haps_bw_fish, size = attr(haps_bw_fish, "freq"), fast = FALSE)
png("Figures/hap_net_bw.png")
plot(haps_bw_fish, size = attr(haps_bw_fish, "freq"), fast = FALSE)
dev.off()

#Bengal guitarfish
beng <- read.dna("Data/Bengal_guitarfish_R.annandalaei.fasta", format = "fasta")
haps_beng <- haplotype(beng)
haps_beng_fish <-haploNet(haps_beng)
plot(haps_beng_fish, size = attr(haps_beng_fish, "freq"), fast = FALSE)
png("Figures/hap_net_beng.png")
plot(haps_beng_fish, size = attr(haps_beng_fish, "freq"), fast = FALSE)
dev.off()

#Oman cownose Ray
ray <- read.dna("Data/Oman_Cownose_Ray_R.jayakari_corrected.fasta", format = "fasta")
haps_ray <- haplotype(ray) 
haps_ray_fish <-haploNet(haps_ray)
plot(haps_ray_fish, size = attr(haps_ray_fish, "freq"), fast = FALSE) 
png("Figures/hap_net_ray.png")
plot(haps_ray_fish, size = attr(haps_ray_fish, "freq"), fast = FALSE)
dev.off()

#Stripenose guitarfish
stripe <- read.dna("Data/Stripenose_guitarfish_A.variegatus_corrected.fasta", format = "fasta")
haps_stripe <- haplotype(stripe)
haps_stripe_fish <-haploNet(haps_stripe)
plot(haps_stripe_fish, size = attr(haps_stripe_fish, "freq"), fast = FALSE)
png("Figures/hap_net_stripe.png")
plot(haps_stripe_fish, size = attr(haps_stripe_fish, "freq"), fast = FALSE)
dev.off()

#Eyebrow wedgefish (?)
eye <- read.dna("Data/Eyebrow wedgefish_Rynchobatus_c.f.laevis_corrected.fasta", format = "fasta")
haps_eye <- haplotype(eye)
haps_eye_fish <-haploNet(haps_eye)
plot(haps_eye_fish, size = attr(haps_eye_fish, "freq"), fast = FALSE)
png("Figures/hap_net_eye.png")
plot(haps_eye_fish, size = attr(haps_eye_fish, "freq"), fast = FALSE)
dev.off()

