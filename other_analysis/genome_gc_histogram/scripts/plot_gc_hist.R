
library(ggplot2)


#==== Reading arguments =====
args = commandArgs(trailingOnly = TRUE)

table_fname = args[1]
out_fname   = args[2]
#============================



#==== Reading ====
tab = read.table(table_fname, sep = '\t', 
           col.names = c("chr", "start", "end", "gc"))
#=================


pdf(out_fname, width = 1.5, height = 1.5)
ggplot(tab, aes(gc)) + 
  geom_histogram(binwidth=0.3, aes(y = ..density..)) +
  theme_classic() +
  xlim(30,60) +
  labs(x="GC%", y="Genome fraction")
dev.off()
