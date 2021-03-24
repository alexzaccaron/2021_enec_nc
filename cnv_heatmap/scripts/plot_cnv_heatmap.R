
library("ggplot2")
library("reshape")

#=== Arguments ===
args = commandArgs(trailingOnly = TRUE)

in_table_fname    = args[1]
out_heatmap_fname = args[2]
out_dendro_fname  = args[3]
out_table_fname   = args[4]
#=================


#=== Set colot palette
my_colors <- colorRampPalette(c("white", "blue")) 
#===


#==== Read in table ====
# old: comb_cnv_genes = read.table("/Volumes/ALEX/ENECATOR_INITIAL_BASIC_ANALYSES/cnvnator_out/filt_out_overlap_genes/combined_all_genes_overlap_grouped_bygene.bed", sep = '\t',
comb_cnv_genes = read.table(in_table_fname, sep = '\t',
                            col.names = c("isolate", "geneID", "chr", "start", "end", "gene_frac_cov", "cnv_type", "norm_RD", "number_cnv", "cnv_len"))
#=======================


#=== Filter ====
# first, filter based on fraction of gene affected, cnv type and normalized read depth
comb_cnv_genes_filt = subset(comb_cnv_genes, 
                             gene_frac_cov >= 0.8 & cnv_type == 'duplication' & norm_RD >= 1.8)
#===============



# get resulting gene IDs and isolate names
gene_ids = rev( levels( as.factor( comb_cnv_genes_filt$geneID  ) ) )
isolates = levels( as.factor( comb_cnv_genes_filt$isolate ) )



#==== setting up a matrix ======
cnv_mat = matrix(rep(1, times = length(gene_ids) * length(isolates)),
                 nrow = length(gene_ids))

colnames(cnv_mat) = isolates
rownames(cnv_mat) = gene_ids
#=============



#==== filling CNV matrix =====
for( id in gene_ids){
  for(iso in isolates){
    if( nrow( subset(comb_cnv_genes_filt, geneID == id & isolate == iso) ) > 0 ){
      cnv_mat[id, iso] = subset(comb_cnv_genes_filt, geneID == id & isolate == iso)$norm_RD
    }
  }
}
#===========



#=== dendrogram ==
dd <- dist(t(cnv_mat), method = "euclidean")
hc <- hclust(dd, method = "ward.D2")
#===========



#=== Melting in table ===
cnv_melt = melt(cnv_mat)
colnames(cnv_melt) = c("gene_id", "isolate", "copy_number")
#========================



#=== changing values ===
# for better visualization, change all values greater than 5 to 5.
cnv_mat_filt = cnv_melt
cnv_mat_filt[cnv_mat_filt$copy_number > 5, 'copy_number'] = 5
#=======================



#==== Reorder factors ====
# Reordering for plot
cnv_mat_filt$gene_id = factor( cnv_mat_filt$gene_id, levels = rev( levels(cnv_mat_filt$gene_id) )  )
cnv_mat_filt$isolate  = factor( cnv_mat_filt$isolate, levels = c("E1-101", "CAT1", "Ranch9", "MEN8B", "Branching", "DDMME2", "Cstrain", "Lodi")  )
#=========================



#==== Ploting ====
p = ggplot(cnv_mat_filt, aes(isolate, gene_id) ) + 
  geom_tile(aes(fill = copy_number)) +
  scale_fill_gradient(low = "white", high = "blue", name = "Copy number") +
  theme_bw() +
  theme(axis.text.y = element_text(size=4),
        axis.text.x = element_text(size=5, angle=45, hjust = 1)) +
  ylab("") + xlab("") 
#===============



#===== Saving ====
# the heatmap
pdf(out_heatmap_fname, width = 3, height = 5)
p
dev.off()

# the dendrogram
pdf(out_dendro_fname, width = 4, height = 3)
plot(as.dendrogram(hc), horiz = F)
dev.off()

# the table
write.table(cnv_mat, 
            out_table_fname,
            quote = F, sep = '\t', row.names = T)
#================



#== An alternative to ggplot ==
#library("gplots")
#cnv_mat = cbind(cnv_mat, 1)
#cnv_mat[cnv_mat > 5] = 5
#heatmap.2(cnv_mat, scale = "none", Rowv = F, trace = 'none', dendrogram = "col", col = my_colors,
#          distfun = function(x) dist(x,method = 'euclidean'),
#          hclustfun = function(x) hclust(x, method="ward.D2"))




