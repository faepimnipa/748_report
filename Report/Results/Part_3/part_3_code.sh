# Find Target Genes (b3593, b0356, b2952) in GFF

echo "=== Find Target Genes in GFF ==="
grep -E "b3593|b2952|b0356" "$RESULT/bakta_GN6"/*.gff

# Extract Target Gene Protein Sequences (FAA)

echo "=== Extract Protein Sequences ==="
grep -A 1 "b3593" "$RESULT/bakta_GN6"/*.faa > b3593_protein.fasta
grep -A 1 "b0356" "$RESULT/bakta_GN6"/*.faa > b0356_protein.fasta
grep -A 1 "b2952" "$RESULT/bakta_GN6"/*.faa > b2952_protein.fasta

# Extract Target Gene Nucleotide Sequences (FFN)

echo "=== Extract Nucleotide Sequences ==="
grep -A 1 "b3593" "$RESULT/bakta_GN6"/*.ffn > b3593_nucleotide.fasta
grep -A 1 "b0356" "$RESULT/bakta_GN6"/*.ffn > b0356_nucleotide.fasta
grep -A 1 "b2952" "$RESULT/bakta_GN6"/*.ffn > b2952_nucleotide.fasta

# Extract by gene name (gltB, frmA, lacZ) from SPAdes annotation
grep -A 1 "gltB" "$RESULT/prokka_GN6/GN6_prokka.ffn"  > target_genes_nucleotide.fasta
grep -A 1 "frmA" "$RESULT/prokka_GN6/GN6_prokka.ffn"  > target_genes_nucleotide.fasta
grep -A 1 "lacZ" "$RESULT/prokka_GN6/GN6_prokka.ffn"  > target_genes_nucleotide.fasta

# PyMOL
# To put them side by side by activating grid mode 
set grid_mode, on

# turn off
set grid_mode, off

# Comparing this prediction to known modes of proteinase-inhibitor interaction 
colour yellow, colabfold_complex and chain A
colour orange, colabfold_complex and chain B

colabfold_complex / A / align / to molecule (*/CA)
/2sic

zoom colabfold_complex and chain B and resid 61-69


