### Repeat landscape



Snakefile to create repeat landscape from sequences and repeat libraries

The input data is in `data/`, and consists of .fasta files of sequences and the corresponding RepeatMasker repeat library. The name pattern should follow: `example.fasta`, `example_rm_lib.fasta`. With the files in place, run the pipeline:

```bash
snakemake -j 1 --use-conda
```



RepeatMasker will be called to mask the sequences in the fasta file with the corresponding repeat library. The `.align` files produced by RepeatMasker will be analyzed with the `parseRM.pl` script from 4ureliek's  [Parsing-RepeatMasker-Outputs](https://github.com/4ureliek/Parsing-RepeatMasker-Outputs) git repo to create a repeat landscape. The R script `scripts/plot_repeat_landscape.R` will make a bar chart of the repeat landscape.


