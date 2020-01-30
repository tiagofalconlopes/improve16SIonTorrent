#!/bin/sh

# Before start, it was created a MOCK and a HUMAN directories.
#Inside each one I created two more directories: a USEARCH and a VSEARCH.
 
# USEARCH specific steps.
# Inside a USEARCH directory.

# Quality filtering, length truncate, and convert to FASTA ----- uses usearch11.0.667_i86linux32 ----- Only accept the maximum probability of one error/read.
usearch11.0.667_i86linux32 -fastq_filter reads2.fastq -fastq_qmax 44 -fastq_maxee 1.0 -fastq_trunclen 200  -fastaout reads.fa

# Dereplication ----- removes duplicated reads
usearch11.0.667_i86linux32 -fastx_uniques reads.fa -fastaout derep.fa -sizeout

# Abundance sort and discard singletons
usearch11.0.667_i86linux32 -sortbysize derep.fa -fastaout sorted.fa -minsize 2

# OTU clustering using USEARCH
usearch11.0.667_i86linux32 -cluster_otus sorted.fa -otus otus.fa

# Create directories for chimera and nonchimera detection
mkdir non_uchime # No chimera detection with UCHIME. Only clusterization.
mkdir uchime_denovo # De novo chimera detection.
mkdir uchime_ref_rdp # Chimera detection using RDP reference.
mkdir uchime_ref_chimslayer # Chimera detection using Chimera Slayer reference
mkdir uchime_denovo_rdp # De novo chimera detection plus using RDP reference.
mkdir uchime_denovo_chimslayer # De novo chimera detection plus using Chimera Slayer reference.
mkdir uchime_denovo_rdp_chimslayer # De novo chimera detection plus using RDP reference.

# De novo and/or reference guided chimera detection
#de novo
usearch11.0.667_i86linux32 -uchime3_denovo otus.fa -chimeras ./uchime_denovo/de_novo_chimera_otu.fa -uchimeout ./uchime_denovo/uchimelogout.txt -nonchimeras ./uchime_denovo/de_novo_nonchimera_otu.fa
#rdp
usearch11.0.667_i86linux32 -uchime2_ref otus.fa -chimeras ./uchime_ref_rdp/chimera_otu.fa -uchimeout ./uchime_ref_rdp/uchimelogout.txt -notmatched ./uchime_ref_rdp/nonchimera_otu.fa -db /PATH/TO/CHIMERA/REFERENCE/DATABASE/rdp_gold.fa -strand plus -mode sensitive
#chimera slayer
usearch11.0.667_i86linux32 -uchime2_ref otus.fa -chimeras ./uchime_ref_chimslayer/chimera_otu.fa -uchimeout ./uchime_ref_chimslayer/uchimelogout.txt -notmatched ./uchime_ref_chimslayer/nonchimera_otu.fa -db /PATH/TO/CHIMERA/REFERENCE/DATABASE/ChimeraSlayer.fa -strand plus -mode sensitive
#de novo + rdp
usearch11.0.667_i86linux32 -uchime2_ref ./uchime_denovo/de_novo_nonchimera_otu.fa -chimeras ./uchime_denovo_rdp/chimera_otu.fa -uchimeout ./uchime_denovo_rdp/uchimelogout.txt -notmatched ./uchime_denovo_rdp/nonchimera_otu.fa -db /PATH/TO/CHIMERA/REFERENCE/DATABASE/rdp_gold.fa -strand plus -mode sensitive
#de novo + chimera slayer
usearch11.0.667_i86linux32 -uchime2_ref ./uchime_denovo/de_novo_nonchimera_otu.fa -chimeras ./uchime_denovo_chimslayer/chimera_otu.fa -uchimeout ./uchime_denovo_chimslayer/uchimelogout.txt -notmatched ./uchime_denovo_chimslayer/nonchimera_otu.fa -db /PATH/TO/CHIMERA/REFERENCE/DATABASE/ChimeraSlayer.fa -strand plus -mode sensitive
#de novo + rdp + chimera slayer
usearch11.0.667_i86linux32 -uchime2_ref ./uchime_denovo_rdp/nonchimera_otu.fa -chimeras ./uchime_denovo_rdp_chimslayer/chimera_otu.fa -uchimeout ./uchime_denovo_rdp_chimslayer/uchimelogout.txt -notmatched ./uchime_denovo_rdp_chimslayer/nonchimera_otu.fa -db /PATH/TO/CHIMERA/REFERENCE/DATABASE/ChimeraSlayer.fa -strand plus -mode sensitive

# Map reads back to OTU database
# Create a list with the above created diretories.
maindir=( non_uchime uchime_denovo uchime_denovo_chimslayer uchime_denovo_rdp uchime_denovo_rdp_chimslayer uchime_ref_chimslayer uchime_ref_rdp )

for i in "${maindir[@]}"
do
    if [ $i = "non_uchime" ]
    then
        usearch11.0.667_i86linux32 -usearch_global reads.fa -db otus.fa -strand plus -id 0.97 -uc ./${i}/map.uc
        mv otus.fa ./${i}/ # Only to put the otus.fa inside the same diretory in the end.
    elif [ $i = "uchime_denovo" ]
    then
        usearch11.0.667_i86linux32 -usearch_global reads.fa -db ./${i}/de_novo_nonchimera_otu.fa -strand plus -id 0.97 -uc ./${i}/map.uc
    else
        usearch11.0.667_i86linux32 -usearch_global reads.fa -db ./${i}/nonchimera_otu.fa -strand plus -id 0.97 -uc ./${i}/map.uc
    fi
done