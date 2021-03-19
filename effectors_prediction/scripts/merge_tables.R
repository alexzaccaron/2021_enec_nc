

args = commandArgs(trailingOnly=TRUE)


prot_comp    = read.table(args[1], sep = '\t', header = T)
effectorp    = read.table(args[2], sep = '\t', header = T)
predgpi      = read.table(args[3], sep = '\t', header = T)
tmhmm        = read.table(args[4], sep = '\t', header = T)
blast_counts = read.table(args[5], sep = '\t', header = T)
out_table    = args[6]

merged_table = merge(merge(merge(merge(prot_comp, effectorp), predgpi), tmhmm), blast_counts) 


write.table(merged_table, out_table, sep = '\t', row.names = F, quote = F)

