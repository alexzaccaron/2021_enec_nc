### CNV

Currently, a Snakefile to call the R script `plot_cnv_heatmap.R` to create a heatmap and a dendrogram based on the predicted number of copies of genes. Input is `combined_all_genes_overlap_grouped_bygene.bed`, which is a 10-column table containing info about CNV overlapping genes. Format: <isolate> <gene> <chromosome> <start> <end> <gene_fraction_covered by_cnv> <cnv_type> <normalized_read_depth> <number_cnvs> <size_of_cnv>. This table was previously generated from the output of `CNVnator`.



```bash
snakemake -j 1 --use-conda 
```


