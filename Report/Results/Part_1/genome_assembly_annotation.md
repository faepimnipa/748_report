# __Genome Assembly and Annotation Benchmarking Report: GN6_hifix30.fastq__
This report details the bioinformatics pipline utilised for the _de novo_ assembly, benchmarking, and functional annotation of the prokaryotic genome GN6. The analysis was conducted in a Linux environment (Ubuntu) using high-fidelity (HiFi) PacBio sequencing data.

## __1. Data Quality Control (Pre-Assembly)__
The initial stage involves evaluating the raw sequencing reads to ensure data integrity and identify poteintail biases before assembly.
- __FastQC__: Analyses the `fastq` files to provide metrics on base quality scores (Phred), GC content, and sequence length distribution.
- __MultiQC__: Aggregates individual reports into a single summary for streamlined comparative analysis.
__Command__

```bash
# Executing FastQC on the HiFi dataset with 3 threads
fastqc -t 3 -o . ~/748/report/dataset/GN6_hifix30.fastq

# Aggregating results for visualization
multiqc -o mutiqc_result ../fastQC_result
```
![FastQC_quality](https://github.com/faepimnipa/748_report/blob/a596dba4a17d524166e7890506a472d79611af8c/Report/Results/Quality%20Control%20(QC)/MutiQC/multiqc_plots/fastqc_per_base_sequence_quality_plot.png)
__Figure Explanation:__
The __Per Base Sequence Quality__ plot is the primary metric for data integrity. In this dataset, the Phred quality scores (Q-scores) remain consistently above 30 (the "green zone"), indicating a bass-calling accuracy of over 99.9%. For PacBio HiFi data, Q-scores often exceed this, reaching into the Q90 range, which ensures the consensus sequences generated during assembly are highly accurate.

## __2. Genome Assembly__
The objective of this stage is to reconstruct the original genome from the fragmented reads. Two algorithmic approaches, Flye and SPAdes were employed to benchmark performance.
- __Flye__: Specifically optimised for long reads assembler for PacBio data, it utilises a repeat graph approach to resolve complex metagenomes 
- __SPAdes__: A multi-k-mer assembler that can be adapted for HiFi data to provide a comparative structural scaffold. It generates high-accuracy configs by using multi-sized de Bruiji graphs to mitigate the effects of sequencing errors and uneven coverage.
__Command__

```bash
# Flye assembly using PacBio HiFi parameters
flye --pacbio-hifi GN6_hifix30.fastq --out-dir ~/748/report/result/GN6_long

# SPAdes assembly in 'only-assembler' mode with specified k-mer lengths
spades.py --only-assembler -k 21,55,95 -s GN6_hifix30.fastq -o ~/748/report/result/GN6_spades
```

## __3. Assembly Benchmarking and Evaluation (QUAST)__
To determine the biological accuracy of the assembly, __QUAST__ (Quality Assessment Tool for Genome Assemblies) is used to compare the _de novo_ configs against a reference genome (_E.coli_ K12).
__command__

```bash
# Evaluates assembly metrics against a reference FASTA file
quast.py ~/748/report/result/GN6_long/assembly.fasta \
         -r ~/748/report/ref/*.fna \
         -o ~/748/report/result/quast_results
```

## __4. Functional Annotation and Gene Calling__
Annotation involves identifying the locations of genes (CDS, tRNA, rRNA) and assigning biological functions to them. Two pipelines were utilised, __Bakta__ (modern, database-rich) and __Prokka__ (rapid, industry standard).
__Command__

```bash
# Executes Bakta annotation using a specialized light database
bakta --db ~/tmp_data/db-light --output ~/748/report/result/bakta_GN6 --prefix GN6_annotation assembly.fasta

# Executes Prokka for rapid prokaryotic feature prediction
prokka --outdir ~/748/report/result/prokka_GN6 --prefix GN6_prokka assembly.fasta
```
## __5. Target Gene Extraction__
The final phase involves isolating specific loci of interest for downstream molecular analysis. Identified and extracted specific genes of interest from the Bakta results.
__Command__

```bash
grep -A 1 "Gene name" ~/748/report/result/bakta_GN6/*.faa > [gene_name]_protein.fasta
```

## __6. Visualise graph__
__Command__

```bash
Bandage image assembly_graph.gfa assembly_visualization.png
```

