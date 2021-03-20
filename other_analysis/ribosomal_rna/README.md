### Ribosomal RNA
Searched rRNA in the genome using Neurospora crassa 28S, 5.8S and 18S sequences (XR_898035.1, XR_898034.1, and XR_898033.1). For 5S, I used Monilinia fructicola 5S sequence (E00049). This one I downloaded from the [5SrRNAdb](http://combio.pl/rrna).

Searches were conducted with BLASTn (-evalue 1e-3 and -task blastn). Matches are in `rrna_blast_matches_locations.txt`. The script `plot_ITS_5S_loci.R` plots the regions:

#### 28S, 5.8S, 18S

Tandem repeats are located within a 45.6 kb region in chromosome 8 (chr08:4,770,868-4,816,449). Five complete copies composed of 18S, 5.8S, and 28S were identified. One additional copy appear to be split between 18S and 5.8S,28S. The size of 18S was 1,736 bp, 5.8S was 152 bp, and 28S was 2,890 bp. No protein-coding gene was predicted within the locus.

![ITS](plots/locus_ITS_chr08.pdf)

#### 5S

The 5S rRNAs were located with two clusters, one with 29 copies of 5S within a 53.0 kb region of chromome 1 (chr01:2,051,232-2,104,286), and the other with 50 copies of 5S within a 95.9 kb region of chromosome 8 (chr08:3,643,482-3,739,378), totalizing 79 copies. The size of all copies were predicted to be 119 bp, except for the last copy in chr08 that had 82 bp. No protein-coding gene was predicted within both loci.

![5s_chr08](plots/locus_5S_chr08.pdf)

![5S_chr01](plots/locus_5S_chr01.pdf)