#!/bin/sh

# Before start, it was created a MOCK and a HUMAN directories.
#Inside each one I created two more directories: a USEARCH and a VSEARCH.

# VSEARCH specific steps.
# Inside a VSEARCH directory.

# Quality filtering, length truncate, and convert to FASTA ----- uses vsearch ----- Only accept the maximum probability of one error/read.
vsearch --fastq_filter reads2.fastq --fastq_qmax 44 --fastq_maxee 1.0 --fastq_trunclen 200  --fastaout reads.fa

# Dereplication ----- removes duplicated reads
vsearch --derep_fulllength reads.fa --output derep.fa --sizeout

# Abundance sort and discard singletons
vsearch --sortbysize derep.fa --output sorted.fa --minsize 2

# OTU clustering using VSEARCH
vsearch --cluster_size sorted.fa --consout otus.fa --id 0.97

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
vsearch --uchime_denovo otus.fa --chimeras ./uchime_denovo/de_novo_chimera_otu.fa --nonchimeras ./uchime_denovo/de_novo_nonchimera_otu.fa
#rdp
vsearch --uchime_ref otus.fa --chimeras ./uchime_ref_rdp/chimera_otu.fa --nonchimeras ./uchime_ref_rdp/nonchimera_otu.fa --db /PATH/TO/CHIMERA/REFERENCE/DATABASE/rdp_gold.fa -strand plus
#chimera slayer
vsearch --uchime_ref otus.fa --chimeras ./uchime_ref_chimslayer/chimera_otu.fa --nonchimeras ./uchime_ref_chimslayer/nonchimera_otu.fa --db /PATH/TO/CHIMERA/REFERENCE/DATABASE/ChimeraSlayer.fa -strand plus
#de novo + rdp
vsearch --uchime_ref ./uchime_denovo/de_novo_nonchimera_otu.fa --chimeras ./uchime_denovo_rdp/chimera_otu.fa --nonchimeras ./uchime_denovo_rdp/nonchimera_otu.fa --db /PATH/TO/CHIMERA/REFERENCE/DATABASE/rdp_gold.fa -strand plus
#de novo + chimera slayer
vsearch --uchime_ref ./uchime_denovo/de_novo_nonchimera_otu.fa --chimeras ./uchime_denovo_chimslayer/chimera_otu.fa --nonchimeras ./uchime_denovo_chimslayer/nonchimera_otu.fa --db /PATH/TO/CHIMERA/REFERENCE/DATABASE/ChimeraSlayer.fa -strand plus
#de novo + rdp + chimera slayer
vsearch --uchime_ref ./uchime_denovo_rdp/nonchimera_otu.fa --chimeras ./uchime_denovo_rdp_chimslayer/chimera_otu.fa --nonchimeras ./uchime_denovo_rdp_chimslayer/nonchimera_otu.fa --db /PATH/TO/CHIMERA/REFERENCE/DATABASE/ChimeraSlayer.fa -strand plus

# Map reads back to OTU database
# Create a list with the above created diretories.
maindir=( non_uchime uchime_denovo uchime_denovo_chimslayer uchime_denovo_rdp uchime_denovo_rdp_chimslayer uchime_ref_chimslayer uchime_ref_rdp )

for i in "${maindir[@]}"
do
    if [ $i = "non_uchime" ]
    then
        vsearch --usearch_global reads.fa --db otus.fa --strand plus --id 0.97 --uc ./${i}/map.uc
        mv otus.fa ./${i}/ # Only to put the otus.fa inside the same diretory in the end.
    elif [ $i = "uchime_denovo" ]
    then
        vsearch --usearch_global reads.fa --db ./${i}/de_novo_nonchimera_otu.fa --strand plus --id 0.97 --uc ./${i}/map.uc
    else
        vsearch --usearch_global reads.fa --db ./${i}/nonchimera_otu.fa --strand plus --id 0.97 --uc ./${i}/map.uc
    fi
done