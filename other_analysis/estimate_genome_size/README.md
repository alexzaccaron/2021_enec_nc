
### Genome size estimation

The Snakefile runs BBmap `kmercountexact.sh` and `GenomeScope2` to estimate the genome size. Reads should be in `data/`. Adjust the `SAMPLES` in the first file of the Snakefile to match the file names in `data/`, i.e., `<sample>` matches `data/<sample>_R1.fastq.gz` and `data/<sample>_R2.fastq.gz`. The mitochondrial genome will be downloaded to filter out mtDNA reads. The filtered reads are used as input to `kmercountexact.sh` and to `jellyfish`. Resulting files are in `output_files/`.

```bash
snakemake -j 1 --use-conda
```


