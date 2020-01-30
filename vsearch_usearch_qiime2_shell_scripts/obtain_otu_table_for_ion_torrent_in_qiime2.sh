#!/bin/bash

# This script start point is a FASTQ file, filtered with reads of 200bp and a max of 1  potential mistake base. identical to those from USEARCH/VSEARCH pipelines.
# It is necessary one FASTQ file per sample (see manifest.txt model)

# Before start, activate QIIME 2 using he following command: source activate qiime2-2019.7
# We performed only steps necessary to obtain an OTU table to compare with USEARCH/VSEARCH pipelines.

# This step uses the manifest.txt file. The -type flag is set to single-end reads and the input format set to
# PHRED positional quality 33. see QIIME2 documentation for details (<https://docs.qiime2.org/2019.10/tutorials/importing/>)
qiime tools import \
  --type 'SampleData[SequencesWithQuality]' \
  --input-path manifest.txt \
  --output-path single-end-demux.qza \
  --input-format SingleEndFastqManifestPhred33

# Denoise and dereplicate using DADA2 (<https://docs.qiime2.org/2017.10/plugins/available/dada2/denoise-single/>)
qiime dada2 denoise-single --i-demultiplexed-seqs single-end-demux.qza --p-trunc-len 0 --output-dir ./resdada

# Use sklearn to test the classifier (<https://docs.qiime2.org/2019.10/tutorials/feature-classifier/>)
# the qza file was downloaded from (<https://data.qiime2.org/2019.10/common/gg-13-8-99-515-806-nb-classifier.qza>)
# We used the trained classifier from Greengenes. QIIME2 webbsite also has a link to the SILVA trained classifier.
qiime feature-classifier classify-sklearn \
  --i-classifier gg-13-8-99-515-806-nb-classifier.qza \
  --i-reads /FULL/PATH/TO/resdada/representative_sequences.qza \
  --o-classification taxonomy.qza

# Collapse features by taxonomy level
qiime taxa collapse --i-table /FULL/PATH/TO/resdada/table.qza --i-taxonomy taxonomy.qza --p-level 7 --output-dir taxtable/

cd taxtable/

# Export features  (<https://docs.qiime2.org/2019.10/tutorials/exporting/>)
qiime tools export --input-path collapsed_table.qza --output-path exported-feature-table

cd exported-feature-table/

# Convert BIOM table to a tab delimited format.
biom convert -i feature-table.biom -o table_tax.tsv --to-tsv
