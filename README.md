# LIFE748 Assessment 2 - Scientific Report
This will include topics covered by Daniel Rigden (Structural Bioinformatics in November and December, Semester 1), Tarang Mehta (Genome assembly and Annotation in February, Semester 2), and Francesco Del Carratore (Machine Learning in February and March, Semester 2). Students are reminded that:
  - This assessment is worth 60% of LIFE748 core module

## Benchmarking tools for genome assembly, annotation, and functional analysis using machine learning and structural bioinformatics
The aim of LIFE748 Assessment 2 will be to benchmark state-of-the-art bioinformatics tools across several essential tasks typically performed by a bioinformatics core facility. It will begin with assessing the accuracy and efficiency of genome assembly and annotation tools for the model prokaryotic organism, _Escherichia coli_, followed by downstream analysis of differentially expressed genes (DEGs) under two distinct experimental conditions using machine learning methods. Lastly, it will focus on structural bioinformatics analyses of selected DEGs, including transcription factors (TFs), to predict protein structures and model protein-DNA interactions. 
This report, mirroring practices in a professional setting, will provide comprehensive benchmark metrics and methods for functional analyses, and can help guide optimal tool choice and parameter settings for core facility applications.

## Results and Analysis - Aims and Objectives 
### 1. Genome Assembly and Annotation Benchmarking 
_Research question: How do leading genome assembly (Flye, SPAdes) and annotation pipelines (Prokka, Bakta) differ in their accuracy, completeness, and computational efficiency when applied to E. coli sequencing data?_
  - Utilise E. coli sequencing reads to perform genome assembly using the modern assembly tools Flye and SPAdes.
    - You will be provided with one of the three Pacbio E. coli 30x coverage reads (GN3, GN6 or GN9) that you used in the ‘LIFE748 Genome Assembly/Annotation’ workshop
    - These (GN3, GN6 or GN9) are three separate clinical samples from three separate septic patients sequenced with PacBio HiFi reads, identified as E. coli/Shigella (Note: Shigella is just E. coli with some additional toxicity genes.)
    - 30x refers to 30-fold coverage sequencing depth of the E. coli genome
    - DNA extraction methods: DNA was isolated with a Qiagen Power Max Soil kit following the manufacturer's instructions.
      - (https://www.qiagen.com/us/products/discovery-and-translationalresearch/dna-rna-purification/dna-purification/microbialdna/dneasy-powermax-soil-kit)
    - Library preparation: SMRTbell prep kit 3.0 (size selection?) 
      - https://www.pacb.com/products-and-services/consumables/library-prep-and-barcoding-kits/ Links to an external site. 
§ Sequencing and base-calling: Sequencing was done on an Sequel IIe 
machine, with basecalling by SMRT LINK V13.0 (using manufactures settings 
for HiFi reads). 
o Compare and benchmark assembly outputs focusing on summary metrics 
including: total assembly size, number of contigs, N50, largest contig length, 
assembly completeness, and computational resource usage (runtime and memory). 
Are there any other metrics to include that would be useful for the genomics 
community? If so, include them and justify with reasoning. 
o Perform genome annotation using Prokka and Bakta pipelines. 
o Evaluate annotations by comparing total gene count, coding sequence predictions, 
ribosomal and transfer RNA genes detected, functional annotation coverage, and 
runtime e iciency. Are there any other metrics to include that would be useful for 
the genomics community? If so, include them and justify with reasoning. 
o Create figures to compare genome assembly summary metrics and gene 
annotations – look at published papers to gain inspiration on how best to visualise 
and compare these datasets between di erent tools.  
o Refer to the ‘LIFE748 Genome Assembly/Annotation’ workshop materials for 
additional guidance on methods 
2. Machine Learning Analysis of Di erential Expression 
Research question: Can machine learning approaches (unsupervised clustering and supervised 
classification) robustly discriminate experimental conditions from E. coli gene expression 
profiles, and which expression features emerge as the most biologically informative markers? 
o Analyse the provided count matrix of DEGs from two experimental conditions. 
o Apply unsupervised clustering (e.g., k-means, hierarchical clustering) to identify 
groupings in gene expression data. 
o Perform supervised classification using logistic regression, Linear Discriminant 
Analysis (LDA), and Support Vector Machines (SVM) to distinguish conditions based 
on expression profiles. 
o Evaluate model performance with accuracy, sensitivity, specificity, and cross
validation metrics, and interpret biologically meaningful markers. 
o NOTE: the code for the initial processing of the data is available in the .qmd file – 
please upload the quarto document (or the R script) you use to perform the 
analysis with your submission as a supplementary material file 
3. Structural Bioinformatics of Di erentially Expressed Genes 
Research question: To what extent can structural modelling (AlphaFold) of di erentially 
expressed proteins and application of structure-based function annotation methods, shed light 
on their roles? 
o Select a subset of DEGs, including key TFs that are di erentially expressed between 
conditions. 
1. Think about a biological rationale for selecting the TFs that you focus on 
further – do they have a role of interest to E. coli function? Are they 
associated with toxicity or resistance? 
2. Consider starting with one or two TFs and going from there ..  
o Extract protein sequences for these DEGs from the genome annotations (in Part 1). 
o Use AlphaFold to predict high-confidence protein structures for the selected 
proteins. 
o Use structure-based function annotation to predict/confirm functional sites e.g. 
DNA-binding sites for the TFs. Examples could include: 
Data Availability 
To avoid any collusion, unique data will be provided to each of you, covering Parts 1 and 2 
above.  Part 3 involves using outputs from Part 2.  
