
# just a pallete with colors for the sequences
pallete=c(
  "#5F2D91",
  "#9462C6",
  "#F4C2FF",
  "#0096C8")
names(pallete) = c("28S", "5.8S", "18S", "5S")


# read table with blast hits (outfmt 6). First column contains the molecule name
rrna_locations = read.table("rrna_blast_matches_locations.txt", sep = '\t', header = T)


#==== Plot ITS ====
rrna_locations_ITS = subset(rrna_locations, molecule %in% c("18S", "5.8S","28S") )
pdf("locus_ITS_chr08.pdf", width = 6, height = 3)
plot(1, xlim=c(4770000,4820000), ylim=c(1,10), type='n', axes=F, xlab="Position in chr08", ylab="")
axis(1)
abline(h=3, lwd=3)
for(i in 1:nrow(rrna_locations)){
  rect(rrna_locations_ITS[i,'sstart'], 2, rrna_locations_ITS[i,'send'], 4, col = pallete[rrna_locations_ITS[i, 'molecule']], lwd=0.5)
}
legend("topright", fill = (pallete[1:3]), legend = names(pallete[1:3]), cex = 0.7, horiz = T) 
dev.off()
#=============



#==== Plot 5S  ====
pdf("locus_5S_chr08.pdf", width = 6, height = 3)
rrna_locations_5S = subset(rrna_locations, molecule == "5S" & chr == "chr08" )
plot(1, xlim=c(3640000,3740000), ylim=c(1,10), type='n', axes = F, xlab="Position in chr08", ylab="")
axis(1)
abline(h=3, lwd=3)
for(i in 1:nrow(rrna_locations)){
  rect(rrna_locations_5S[i,'sstart'], 2, rrna_locations_5S[i,'send'], 4, col = pallete[rrna_locations_5S[i, 'molecule']], lwd=0.5)
}
dev.off()

pdf("locus_5S_chr01.pdf", width = 6, height = 3)
rrna_locations_5S = subset(rrna_locations, molecule == "5S" & chr == "chr01" )
plot(1, xlim=c(2050000,2105000), ylim=c(1,10), axes = F, type='n', xlab="Position in chr01", ylab="")
axis(1)
abline(h=3, lwd=3)
for(i in 1:nrow(rrna_locations)){
  rect(rrna_locations_5S[i,'sstart'], 2, rrna_locations_5S[i,'send'], 4, col = pallete[rrna_locations_5S[i, 'molecule']], lwd=0.5)
}
dev.off()
#============

