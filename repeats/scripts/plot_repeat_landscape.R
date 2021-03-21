library(tidyr)
library(ggplot2)


# input and output file names
args = commandArgs(trailingOnly=TRUE)
in_filename  = args[1]
out_filename = args[2]



#cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

cbPalette <- c("#67c1a4", "#fb8c62", "#8c9fca", "#ffd82f", "#e689c2", "#a5d755", "#8c8c8c")

# 
tab = read.table(in_filename,
                 col.names = c('type', 1:50))


tab = gather(tab, divergence, value, X1:X50, factor_key=TRUE)

pdf(out_filename, width = 5, height = 3)
ggplot(tab, aes(fill=type, y=value, x=divergence)) + 
  geom_bar(position='stack', stat='identity') +
  ylim(0,3.5e+06) +
  scale_fill_manual(values=cbPalette) +
  theme_classic() +
  scale_x_discrete(1:50, labels = c(1, rep("", 8), 10, rep("", 9), 20, rep("", 9), 30, rep("", 9), 40, rep("", 9), 50)) +
  ylab("Abundance (bp)")
dev.off()
