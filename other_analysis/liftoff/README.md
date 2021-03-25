### Liftoff



Snakefile to perform [liftoff](https://github.com/agshumate/Liftoff) the annotations from the annotation of the reference to the old genome assembly. Input is a GFF and a fasta file in `data/ref`. With these set:

```bash
snakemake -j --use-conda
```

should download the old genome and performs the lift. Inportant output is in the `liftoff_out` directory.
