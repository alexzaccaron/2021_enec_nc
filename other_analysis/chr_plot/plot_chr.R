

colfunc1 <- colorRampPalette(c("white", "black"))
colfunc2 <- colorRampPalette(c("#328bbc","#fef6be", "#d43f56"))
pallet_gene = colfunc1(20)
pallet_rept = colfunc2(100)
plot(1, type="n", xlim=c(0,100), ylim=c(0,5))
for(i in 1:100){
  segments(i, 0, i, 1, col=pallet_rept[i], lwd=5)
}

gene_count = read.table("chr_windows_gene_count.txt", col.names = c("scaffold", "start", "end", "count"))
repeat_cov = read.table("chr_windows_repeats.txt", col.names = c("scaffold", "start", "end", "count", "cov_bases", "length", "fraction"))
genome_size = read.table("chr_size.txt", col.names = c("scaffold", "length"))
#secreted_proteins = read.table("secreted_proteins.bed", col.names = c("scaffold", "start", "end", "ID"))


repeat_cov$fraction = round(repeat_cov$fraction*100)

#png("Enec101_chromosomes.png", res=300, units = "in", width = 6, height = 7)
pdf("Enec101_chromosomes.pdf", width = 6, height = 7)
plot(1, type="n", xlim=c(0,12000000), ylim=c(0,32), axes = F, ann = F)


for(chr in 1:11){
  y=27-((chr-1)*2.7)
  
  gene_count_subset = subset(gene_count, scaffold==genome_size[chr,'scaffold'])
  repeat_cov_subset = subset(repeat_cov, scaffold==genome_size[chr,'scaffold'])
  
  for(i in 1:nrow(gene_count_subset)){
    rect(gene_count_subset[i,'start'], y, gene_count_subset[i,'end'], y+1, border = NA, col = pallet_gene[gene_count_subset[i,'count']])
    rect(repeat_cov_subset[i,'start'], y-0.5, repeat_cov_subset[i,'end'], y, border = NA, col = pallet_rept[repeat_cov_subset[i,'fraction']])
  }
  
  rect(1, y, genome_size[chr,'length'], y+1, lwd=0.8)
  
  #sec_subset = subset(secreted_proteins, scaffold==genome_size[chr,'scaffold'])
  #points(sec_subset$start, rep(y+1, times=nrow(sec_subset)), pch=6, col="blue", cex=0.7)
 
}
axis(3, labels = F)

#MAT chr05:3878609-3879524
segments(3878609, 17.2, 3978609, 17.6, lwd=2)
text(3878609, 17.6, "MAT locus", pos = 4, cex = 0.5, offset = 0.3)

#ITS chr08:4770868-4816449
segments(4816449, 9.2, 4916449, 9.5, lwd=2)
text(4816449, 9.6, "18S-28S rDNA", pos = 4, cex = 0.5, offset = 0.3)


#5S cluster 1 chr08:3643482-3739378
segments(3739378, 9.2, 3839378, 9.5, lwd=2)
text(3739378, 9.6, "5S rDNA", pos = 4, cex = 0.5, offset = 0.3)


#5S group 2 chr01:2051232-2104286
segments(2104286, 28, 2204286, 28.5, lwd=2)
text(2104286, 28.6, "5S rDNA", pos = 4, cex = 0.5, offset = 0.3)





#library(plotrix)
#par(xpd=TRUE)
#draw.circle(30025,-1.6, 30025, lwd=1)


dev.off()



#legend
pdf("Enec101_chromosomes_legend_gene.pdf", width = 5, height = 5)
plot(1, type="n", xlim=c(0,40), ylim=c(0,10), axes = F, ann = F)
for(i in 1:length(pallet_gene)){
  rect(i,1,i+1,2, border = NA, col=pallet_gene[i])
}
rect(1,1,21,2, lwd=0.5)
dev.off()




pdf("Enec101_chromosomes_legend_repeat.pdf", width = 5, height = 5)
plot(1, type="n", xlim=c(0,110), ylim=c(0,10), axes = F, ann = F)
for(i in 1:length(pallet_rept)){
  rect(i,1,i+1,2, border = NA, col=pallet_rept[i])
}
rect(1,1,101,2, lwd=0.5)
dev.off()
