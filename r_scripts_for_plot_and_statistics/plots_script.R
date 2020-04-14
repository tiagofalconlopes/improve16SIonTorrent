# Adapt to your files names and colnames
# Here we have a file for each taxonomic level
# with the column names. Example:
#U_or_V	chimera	database	Level	count
#usearch	mock_usearch_non_uchime	rdp05_gg94.biom.spf	Level_1	26
#usearch	mock_usearch_non_uchime	rdp05_gg97.biom.spf	Level_1	26
#usearch	mock_usearch_non_uchime	rdp05_gg99.biom.spf	Level_1	26
#usearch	mock_usearch_non_uchime	rdp05_silva94.biom.spf	Level_1	26
#usearch	mock_usearch_non_uchime	rdp05_silva97.biom.spf	Level_1	26
#usearch	mock_usearch_non_uchime	rdp05_silva99.biom.spf	Level_1	26
#usearch	mock_usearch_non_uchime	rdp08_gg94.biom.spf	Level_1	26
#usearch	mock_usearch_non_uchime	rdp08_gg97.biom.spf	Level_1	26
#usearch	mock_usearch_non_uchime	uclust09_gg99.biom.spf	Level_1	26
#usearch	mock_usearch_non_uchime	uclust09_silva94.biom.spf	Level_1	26
#usearch	mock_usearch_non_uchime	uclust09_silva97.biom.spf	Level_1	26
#usearch	mock_usearch_non_uchime	uclust09_silva99.biom.spf	Level_1	26
#usearch	mock_usearch_uchime_denovo_chimslayer	rdp05_gg94.biom.spf	Level_1	23
#usearch	mock_usearch_uchime_denovo_chimslayer	rdp05_gg97.biom.spf	Level_1	23
#vsearch	mock_vsearch_uchime_denovo	rdp09_silva94.biom.spf	Level_1	33
#vsearch	mock_vsearch_uchime_denovo	rdp09_silva97.biom.spf	Level_1	33
#vsearch	mock_vsearch_uchime_denovo	rdp09_silva99.biom.spf	Level_1	33
#vsearch	mock_vsearch_uchime_denovo_rdp_chimslayer	rdp05_gg94.biom.spf	Level_1	30
#vsearch	mock_vsearch_uchime_denovo_rdp_chimslayer	rdp05_gg97.biom.spf	Level_1	30
#vsearch	mock_vsearch_uchime_denovo_rdp_chimslayer	rdp05_gg99.biom.spf	Level_1	30
#	
library(ggplot2)
setwd("/PATH/TO/CSV/COUNTING/TABLES/")
file <- read.csv("uniq_mock_Level_7_counting.csv")
head(file)
#plot data
p1<-ggplot(file, aes(x=U_or_V, y=count, fill=U_or_V)) +
  geom_boxplot()
pdf("mock_Level_7_U_x_V.pdf")
p1
dev.off()

p2<-ggplot(file, aes(x=chimera, y=count, fill=chimera)) + theme(text = element_text(size=8),
  axis.text.x = element_text(angle=60, hjust=1)) + geom_boxplot()
pdf("mock_Level_7_chimera_or_not_and_ref.pdf")
p2
dev.off()

p3<-ggplot(file, aes(x=database, y=count, fill=database)) + theme(text = element_text(size=8),
  axis.text.x = element_text(angle=60, hjust=1)) + geom_boxplot()
pdf("mock_Level_7_database_gg_silva_conf.pdf")
p3
dev.off()

