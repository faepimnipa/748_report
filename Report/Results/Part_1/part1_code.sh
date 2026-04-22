#!/bin/bash
# Part 1 – Genome Assembly and Annotation Benchmarking
# Prokaryotic Genome Assembly & Annotation Pipeline

set -euo pipefail

# --- Paths ---
DATASET=~/748/report/dataset
RESULT=~/748/report/result
REF=~/748/report/ref

FASTQ="$DATASET/GN6_hifix30.fastq"

# 1. Quality Control

echo "=== FastQC ==="
fastqc -t 3 -o . "$FASTQ"

echo "=== MultiQC ==="
multiqc -o mutiqc_result ../fastQC_result

# 2. Genome Assembly – Flye (PacBio HiFi)

echo "=== Flye Assembly (PacBio HiFi) ==="
conda run -n genomics_env \
  flye --pacbio-hifi "$FASTQ" \
       --out-dir "$RESULT/GN6_long"

# 3. Genome Assembly – Flye (Nanopore raw)

echo "=== Flye Assembly (Nanopore raw) ==="
conda run -n genomics_env \
  flye --nano-raw "$FASTQ" \
       --genome-size 1m \
       --out-dir "$RESULT/flye_gn6_output"

# 4. Genome Assembly – SPAdes

echo "=== SPAdes Assembly ==="
spades.py --only-assembler \
          -k 21,55,95 \
          -s "$FASTQ" \
          -o "$RESULT/GN6_spades" \
          -t 4 -m 14

# 5. Download Reference Genome (E. coli K12)

echo "=== Download E. coli K12 Reference ==="
mkdir -p "$REF"
wget -r https://cgr.liv.ac.uk/454/acdarby/LIFE748/EcoliK12/EcoliK12_GCA_000005845.2_ASM584v2_genomic.fna \
     -P "$REF"

# 6. Assembly QC – QUAST (single assembly)

echo "=== QUAST – Single Assembly ==="
quast.py "$RESULT/GN6_long/assembly.fasta" \
         -r "$REF"/*.fna \
         --gene-finding \
         --threads 4 \
         -o "$RESULT/quast_results"

# 7. Assembly QC – QUAST (Flye vs SPAdes comparison)

echo "=== QUAST – Flye vs SPAdes Comparison ==="
quast.py "$RESULT/GN6_long/assembly.fasta" \
         "$RESULT/GN6_spades/scaffolds.fasta" \
         -r "$REF"/*.fna \
         -o "$RESULT/quast_comparison"

# 8. Annotation – Bakta

echo "=== Bakta Annotation ==="
conda run -n bakta \
  bakta --db ~/tmp_data/db-light \
        --output "$RESULT/bakta_GN6" \
        --prefix GN6_annotation \
        "$RESULT/GN6_long/assembly.fasta"

# 9. Annotation – Prokka

echo "=== Prokka Annotation ==="
conda run -n prokka \
  prokka --outdir "$RESULT/prokka_GN6" \
         --prefix GN6_prokka \
         "$RESULT/GN6_long/assembly.fasta"

# 10. Annotation Summary (Prokka)

echo "=== Prokka Feature Counts ==="
grep -E 'CDS:|rRNA:|tRNA:' "$RESULT/prokka_GN6/GN6_prokka.txt"

echo "=== Prokka TSV Feature Summary ==="
cut -f2 "$RESULT/prokka_GN6/GN6_prokka.tsv" | sort | uniq -c


# 11. Visualise Flye Assembly Graph (Bandage)

echo "=== Bandage – Assembly Graph Visualisation ==="
Bandage image "$RESULT/GN6_long/assembly_graph.gfa" \
              "$RESULT/GN6_long/assembly_visualization.png"

(echo -e "Count\tFeature"; cut -f2 GN6_flye_prokka.tsv | sort | uniq -c) | column -t > summary_results.txt
(echo -e "Count\tFeature"; cut -f2 GN6_spades_prokka.tsv | sort | uniq -c) | column -t > summary_results.txt

echo ""
echo "=== Pipeline Complete ==="
