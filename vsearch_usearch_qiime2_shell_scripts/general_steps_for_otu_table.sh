#!/bin/sh

# General steps to be used to obtain the OTU table
# Use this script inside a USEARCH or a VSEARCH directory

# Before start, activate qiime in your console using the following command: source activate qiime1

# Create a list with the above created diretories.
maindir=( non_uchime uchime_denovo uchime_denovo_chimslayer uchime_denovo_rdp uchime_denovo_rdp_chimslayer uchime_ref_chimslayer uchime_ref_rdp )
classf=( rdp uclust)
levconf=( 0.5 0.8 0.9)

# Assign taxonomy step, for classifiers rdp and uclust, and confidence levels of 0.5, 0.8, and 0.9
# The default for, installed from 
# Database Greengenes 94
for i in "${maindir[@]}"
do
    for j in "${classf[@]}"
    do
        for k in "${levconf[@]}"
        do
            if [ $i = "non_uchime" ]
            then
                assign_taxonomy.py -i ./${i}/otus.fa -o ./${i}/output_${j}${k}_gg94 -r /PATH/TO/gg_13_8_otus/rep_set/94_otus.fasta -t /PATH/TO/gg_13_8_otus/taxonomy/94_otu_taxonomy.txt -m ${j} -c ${k}
            elif [ $i = "uchime_denovo" ]
            then
                assign_taxonomy.py -i ./${i}/de_novo_nonchimera_otu.fa -o ./${i}/output_${j}${k}_gg94 -r /PATH/TO/gg_13_8_otus/rep_set/94_otus.fasta -t /PATH/TO/gg_13_8_otus/taxonomy/94_otu_taxonomy.txt -m ${j} -c ${k}
            else
                assign_taxonomy.py -i ./${i}/nonchimera_otu.fa -o ./${i}/output_${j}${k}_gg94 -r /PATH/TO/gg_13_8_otus/rep_set/94_otus.fasta -t /PATH/TO/gg_13_8_otus/taxonomy/94_otu_taxonomy.txt -m ${j} -c ${k}
            fi
        done
    done
done

# Database Greengenes 97
for i in "${maindir[@]}"
do
    for j in "${classf[@]}"
    do
        for k in "${levconf[@]}"
        do
            if [ $i = "non_uchime" ]
            then
                assign_taxonomy.py -i ./${i}/otus.fa -o ./${i}/output_${j}${k}_gg97 -r /PATH/TO/gg_13_8_otus/rep_set/97_otus.fasta -t /PATH/TO/gg_13_8_otus/taxonomy/97_otu_taxonomy.txt -m ${j} -c ${k}
            elif [ $i = "uchime_denovo" ]
            then
                assign_taxonomy.py -i ./${i}/de_novo_nonchimera_otu.fa -o ./${i}/output_${j}${k}_gg97 -r /PATH/TO/gg_13_8_otus/rep_set/97_otus.fasta -t /PATH/TO/gg_13_8_otus/taxonomy/97_otu_taxonomy.txt -m ${j} -c ${k}
            else
                assign_taxonomy.py -i ./${i}/nonchimera_otu.fa -o ./${i}/output_${j}${k}_gg97 -r /PATH/TO/gg_13_8_otus/rep_set/97_otus.fasta -t /PATH/TO/gg_13_8_otus/taxonomy/97_otu_taxonomy.txt -m ${j} -c ${k}
            fi
        done
    done
done

# Database Greengenes 99
for i in "${maindir[@]}"
do
    for j in "${classf[@]}"
    do
        for k in "${levconf[@]}"
        do
            if [ $i = "non_uchime" ]
            then
                assign_taxonomy.py -i ./${i}/otus.fa -o ./${i}/output_${j}${k}_gg99 -r /PATH/TO/gg_13_8_otus/rep_set/99_otus.fasta -t /PATH/TO/gg_13_8_otus/taxonomy/99_otu_taxonomy.txt -m ${j} -c ${k}
            elif [ $i = "uchime_denovo" ]
            then
                assign_taxonomy.py -i ./${i}/de_novo_nonchimera_otu.fa -o ./${i}/output_${j}${k}_gg99 -r /PATH/TO/gg_13_8_otus/rep_set/99_otus.fasta -t /PATH/TO/gg_13_8_otus/taxonomy/99_otu_taxonomy.txt -m ${j} -c ${k}
            else
                assign_taxonomy.py -i ./${i}/nonchimera_otu.fa -o ./${i}/output_${j}${k}_gg99 -r /PATH/TO/gg_13_8_otus/rep_set/99_otus.fasta -t /PATH/TO/gg_13_8_otus/taxonomy/99_otu_taxonomy.txt -m ${j} -c ${k}
            fi
        done
    done
done

# Database SILVA 94
for i in "${maindir[@]}"
do
    for j in "${classf[@]}"
    do
        for k in "${levconf[@]}"
        do
            if [ $i = "non_uchime" ]
            then
                assign_taxonomy.py -i ./${i}/otus.fa -o ./${i}/output_${j}${k}_silva94 -r /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/rep_set/rep_set_16S_only/94/silva_132_94_16S.fna -t /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/taxonomy/16S_only/94/consensus_taxonomy_7_levels.txt -m ${j} -c ${k}
            elif [ $i = "uchime_denovo" ]
            then
                assign_taxonomy.py -i ./${i}/de_novo_nonchimera_otu.fa -o ./${i}/output_${j}${k}_silva94 -r /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/rep_set/rep_set_16S_only/94/silva_132_94_16S.fna -t /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/taxonomy/16S_only/94/consensus_taxonomy_7_levels.txt -m ${j} -c ${k}
            else
                assign_taxonomy.py -i ./${i}/nonchimera_otu.fa -o ./${i}/output_${j}${k}_silva94 -r /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/rep_set/rep_set_16S_only/94/silva_132_94_16S.fna -t /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/taxonomy/16S_only/94/consensus_taxonomy_7_levels.txt -m ${j} -c ${k}
            fi
        done
    done
done

# Database SILVA 97
for i in "${maindir[@]}"
do
    for j in "${classf[@]}"
    do
        for k in "${levconf[@]}"
        do
            if [ $i = "non_uchime" ]
            then
                assign_taxonomy.py -i ./${i}/otus.fa -o ./${i}/output_${j}${k}_silva97 -r /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/rep_set/rep_set_16S_only/97/silva_132_97_16S.fna -t /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/taxonomy/16S_only/97/consensus_taxonomy_7_levels.txt -m ${j} -c ${k}
            elif [ $i = "uchime_denovo" ]
            then
                assign_taxonomy.py -i ./${i}/de_novo_nonchimera_otu.fa -o ./${i}/output_${j}${k}_silva97 -r /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/rep_set/rep_set_16S_only/97/silva_132_97_16S.fna -t /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/taxonomy/16S_only/97/consensus_taxonomy_7_levels.txt -m ${j} -c ${k}
            else
                assign_taxonomy.py -i ./${i}/nonchimera_otu.fa -o ./${i}/output_${j}${k}_silva97 -r /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/rep_set/rep_set_16S_only/97/silva_132_97_16S.fna -t /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/taxonomy/16S_only/97/consensus_taxonomy_7_levels.txt -m ${j} -c ${k}
            fi
        done
    done
done

# Database SILVA 99
for i in "${maindir[@]}"
do
    for j in "${classf[@]}"
    do
        for k in "${levconf[@]}"
        do
            if [ $i = "non_uchime" ]
            then
                assign_taxonomy.py -i ./${i}/otus.fa -o ./${i}/output_${j}${k}_silva99 -r /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/rep_set/rep_set_16S_only/99/silva_132_99_16S.fna -t /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/taxonomy/16S_only/99/consensus_taxonomy_7_levels.txt -m ${j} -c ${k}
            elif [ $i = "uchime_denovo" ]
            then
                assign_taxonomy.py -i ./${i}/de_novo_nonchimera_otu.fa -o ./${i}/output_${j}${k}_silva99 -r /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/rep_set/rep_set_16S_only/99/silva_132_99_16S.fna -t /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/taxonomy/16S_only/99/consensus_taxonomy_7_levels.txt -m ${j} -c ${k}
            else
                assign_taxonomy.py -i ./${i}/nonchimera_otu.fa -o ./${i}/output_${j}${k}_silva99 -r /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/rep_set/rep_set_16S_only/99/silva_132_99_16S.fna -t /PATH/TO/Silva_132_release/SILVA_132_QIIME_release/taxonomy/16S_only/99/consensus_taxonomy_7_levels.txt -m ${j} -c ${k}
            fi
        done
    done
done

# We skipped the align_seqs.py, filter_alignment.py, make_phylogeny.py, and core_diversity_analyses.py because we needed only the OTU table.

# Convert UC to an initial OTU table
for i in "${maindir[@]}"
do
    uc2otutab.py ./${i}/map.uc > ./${i}/otu_table.txt
done

# Convert to BIOM format
for i in "${maindir[@]}"
do
    biom convert -i ./${i}/otu_table.txt -o ./${i}/otu_table.biom --table-type="OTU table" --to-json
done

# Add the metadato to the OTU table in BIOM format
folders=( output_rdp0.5_gg94 output_rdp0.8_gg94 output_rdp0.9_gg94 output_uclust0.5_gg94 output_uclust0.8_gg94 output_uclust0.9_gg94 output_rdp0.5_gg97 output_rdp0.8_gg97 output_rdp0.9_gg97 output_uclust0.5_gg97 output_uclust0.8_gg97 output_uclust0.9_gg97 output_rdp0.5_gg99 output_rdp0.8_gg99 output_rdp0.9_gg99 output_uclust0.5_gg99 output_uclust0.8_gg99 output_uclust0.9_gg99 output_rdp0.5_silva94 output_rdp0.8_silva94 output_rdp0.9_silva94 output_uclust0.5_silva94 output_uclust0.8_silva94 output_uclust0.9_silva94 output_rdp0.5_silva97 output_rdp0.8_silva97 output_rdp0.9_silva97 output_uclust0.5_silva97 output_uclust0.8_silva97 output_uclust0.9_silva97 output_rdp0.5_silva99 output_rdp0.8_silva99 output_rdp0.9_silva99 output_uclust0.5_silva99 output_uclust0.8_silva99 output_uclust0.9_silva99 )

for i in "${maindir[@]}"
do
    if [ $i = "non_uchime" ]
    then
        for j in "${folders[@]}"
        do
            biom add-metadata -i ./${i}/otu_table.biom -o ./${i}/otu_table_tax_${j}.biom --observation-metadata-fp ./${i}/${j}/otus_tax_assignments.txt --observation-header OTUID,taxonomy,confidence --sc-separated taxonomy --float-fields confidence
        done
    elif [ $i = "uchime_denovo" ]
    then
        for j in "${folders[@]}"
        do
            biom add-metadata -i ./${i}/otu_table.biom -o ./${i}/otu_table_tax_${j}.biom --observation-metadata-fp ./${i}/${j}/de_novo_nonchimera_otu_tax_assignments.txt --observation-header OTUID,taxonomy,confidence --sc-separated taxonomy --float-fields confidence
        done
    else
        for j in "${folders[@]}"
        do
            biom add-metadata -i ./${i}/otu_table.biom -o ./${i}/otu_table_tax_${j}.biom --observation-metadata-fp ./${i}/${j}/nonchimera_otu_tax_assignments.txt --observation-header OTUID,taxonomy,confidence --sc-separated taxonomy --float-fields confidence
        done
    fi
done

# Get summarized information
for i in "${maindir[@]}"
do
    # move into the work directory before analysis
    cd ${i}/
    for j in `ls otu_table_tax_*.biom`
    do
        biom summarize-table -i ${j} -o results_biom_table_${j}
    done
    # move back
    cd ..
done

# Convert into STAMP format, which is a simple tab delimited file that can be opened in Excel, for example.
# Requires Python 2.7
for i in "${maindir[@]}"
do
    # move into the work directory before analysis
    cd ${i}/
    for j in `ls otu_table_tax_*.biom`
    do
        python2.7 /PATH/TO/biom_to_stamp.py -m taxonomy ${j} > STAMP_${j}.spf
    done
    # move back
    cd ..
done

# Check if the taxonomic hierarchy file is good to proceed (determine if there is no clear taxonomic mistakes)
for i in "${maindir[@]}"
do
    # move into the work directory before analysis
    cd ${i}/
    #STAMP_*.spf are the OTU tables output from BMP pipeline
    for j in `ls STAMP_*.spf`
    do
        python2.7 /home/tf/Mod_checkHierarchy_line55.py ${j} &> checkHierarchy_${j}.txt
    done
    # move back
    cd ..
done