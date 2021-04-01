# 2021_enec_nc

### `effectors_prediction`
Snakefile to predict effectors. **Note**: Prediction of effectors through a fully automated pipeline is difficult because most of software used for this purpose have license restrictions. Nonetheless, they can all be freely [downloaded](https://services.healthtech.dtu.dk/software.php) for academic use. Maybe one day I manage to fully automate this. But in the meanwhile, some manual intervention is needed. 

+ From a `{sample}.fasta` file with protein sequences, `Snakefile` will try to call `SignalPv5` to identify secreted proteins. `SignalPv5` must be pre-installed and must be in the `PATH`; change it in the `signalp` rule. Also, change the `SAMPLES` in the first line to match the `{sample}.fasta` file.
+ A file `{sample}_secretome.fasta` is then created with proteins containing a signal peptide
+ Protein composition is calculated: length, number and % of cystines
+ EffectorP will run on the secretome. As before, it should be pre-installed. Change its path in the `run_effectorP` rule.
+ Manual intervention here: using the browser, run [predGPI](http://gpcr.biocomp.unibo.it/predgpi/index.htm) and [TMHMM2](http://www.cbs.dtu.dk/services/TMHMM/) on the `{sample}_secretome.fasta`. Download the output of `predGPI` (it is a fasta file) and add/rename it to `results/predgpi/{sample}_predgpi.txt`. When running `TMHMM`, select the long option without graphs. Save the output to `results/tmhmm/{sample}_tmhmm.txt`.
+ **Now**: uncomment the `#expand("{sample}_secretome_table_calls.txt", sample=SAMPLES),` in the rule `all`. This will run the next steps.
+ Protein sequences will be downloaded from NCBI of all Leotiomycetes (except Erysiphales). Info of the species are in `leotio_proteins/proteome_links_leotio_non_erysiphales_genbank_20210318.txt`. All proteins as of 03/18/2021. I got the links to the proteomes from NCBI by using this search query: `"Leotiomycetes"[Organism] NOT "Erysiphales"[Organism] AND (latest[filter] AND "has annotation"[Properties])` in the `Assembly` database. There were 92 in total. I opened the FTP page of one by one, and copied the link to `*_protein.faa.gz`. Not the most efficient, but it's a way of doing it.
+ `Snakefile` will BLASTP the `{sample}_secretome.fasta` against the downloaded proteins
+ There are two auxiliary scripts in `scripts/`. One, `merge_tables.R`, will merge results into a single table, making it easier for comparisons. The other, `call_candidate_effectors.R` will call candidate effectors based on the results. There are three "categories" of candidate effectors
    + Called by EffectorP: any secreted protein classified as effector by EffectorP v2.
    + Based on protein composition: secreted proteins shorter than 250 aa, with at least 2% cysteine, and no transmembrane domain, except within the first 40 aa. The reason for the fist 40 aa is that `TMHMM` typically calls the signal peptide at the N-terminus as transmembrane domain.
    + Based on lack of homology: secreted proteins with no homologs in any Leotiomycetes, except Erysiphales.


At the end, the important file is `{sample}_secretome_table_calls.txt`, which contains the summarized results:
+ `id`: protein ID
+ `length`: protein length (aa)
+ `cysteines_num`: number of cysteine residues
+ `cysteines_perc`: percentage of cysteines residues
+ `EffectorP_res`: EffectorP classification
+ `EffectorP_prob`: EffectorP probability
+ `predGPI_FPrate`: PredGPI FPrate (<=0.005 is likely GPI-anchored)
+ `TMH_num`: number of transmembrane domains
+ `TMH_begin_num`: number of transmembrane domains within first 40 aa
+ `num_blast_hits`: number of blast hits
+ `CEP_by_effectorP`: classified as effector by EffectorP (yes/no)
+ `CEP_by_prot_comp`: classified as effector by protein composition (yes/no)
+ `CEP_by_lack_homology`: classified as effector by lack of homology (yes/no)


#### PHI BLASTp search
The resulting secretome was searched with BLASTp (v2.6.0) against the [PHI database](http://www.phi-base.org/index.jsp) v4.10 with e-value < 1e-10. This BLAST search was not added to the Snakefile because there are restrictions to distribute the PHI database, although it is free to download for academic purposes. The BLASTp results are in `results/PHI_blast`
