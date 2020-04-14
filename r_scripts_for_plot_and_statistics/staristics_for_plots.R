library(PMCMRplus)
setwd("/PATH/TO/CSV/COUNTING/TABLES/")
file <- read.csv("uniq_human_Level_1_counting.csv")
head(file)
# Perform normality test and the adequate  comparisons
data_info <- c()
data_t <- c()
data_fdr <- c()
data_info_wil <- c()
data_wil_w <- c()
data_wil_fdr <- c()
z<-colnames(file[5])
x <- shapiro.test(file$count)
if (length(levels(file$pipeline)) <= 2){
  warning("You don't have more than two groups")} else if (x$p.value >= 0.05 && length(levels(file$pipeline)) >= 3){
    tuk_res <- TukeyHSD(aov(file$count ~ file$pipeline))
    tuk_res$`file$pipeline`[,4] <- p.adjust(tuk_res$`file$pipeline`[,4],method = 'fdr')
    write.table(z, file = "comparisons_human_pipeline_Level_1_tukey.txt", append = TRUE, row.names = FALSE, col.names = FALSE, sep='\t')
    write.table(tuk_res$`file$pipeline`, file = "comparisons_human_pipeline_Level_1_tukey.txt", append = TRUE, row.names = TRUE, col.names = NA, sep='\t')
  } else if (x$p.value < 0.05 && length(levels(file$pipeline)) >= 3){
    krusk_res <- kwAllPairsDunnTest(x=file$count, g=file$pipeline, p.adjust.method="fdr")
    write.table(z, file = "comparisons_human_pipeline_Level_1_kruskal.txt", append = TRUE, row.names = FALSE, col.names = FALSE, sep='\t')
    write.table(krusk_res$method,file = "comparisons_human_pipeline_Level_1_kruskal.txt", append = TRUE, row.names = TRUE, col.names = TRUE, sep='\t')
    write.table(krusk_res$p.value,file = "comparisons_human_pipeline_Level_1_kruskal.txt", append = TRUE, row.names = TRUE, col.names = NA, sep='\t')
    write.table(krusk_res$p.adjust.method,file = "comparisons_human_pipeline_Level_1_kruskal.txt", append = TRUE, row.names = TRUE, col.names = TRUE, sep='\t')
  }
if (length(levels(file$pipeline)) != 2){
  warning("You don't have two groups")} else if (x$p.value >= 0.05 && length(levels(file$pipeline)) == 2){
    ttest_res <- t.test(file$count ~ file$pipeline)
    data_info <- c(data_info, z)
    data_t <- c(data_t, ttest_res[1])
    data_fdr <- c(data_fdr, ttest_res[3])
    data_ttest_sum <- cbind(data_info, data_t, data_fdr)
    colnames(data_ttest_sum)[1:3] <- c('Data', 't_value', 'FDR')
  } else if (x$p.value < 0.05 && length(levels(file$pipeline)) == 2){
    wilcox_res <-wilcox.test(file$count ~ file$pipeline)
    
    data_info_wil <- c(data_info_wil, z)
    data_wil_w <- c(data_wil_w, wilcox_res[1])
    data_wil_fdr <- c(data_wil_fdr, wilcox_res[3])
    data_wil_sum <- cbind(data_info_wil, data_wil_w, data_wil_fdr)
    colnames(data_wil_sum)[1:3] <- c('Data', 'w_value', 'FDR')
}
#
if (length(levels(file$pipeline)) != 2){
  warning("You don't have two groups")} else if (exists('data_ttest_sum') == TRUE){
    data_ttest_sum[,3] <- p.adjust(data_ttest_sum[,3], method = 'fdr')
    write.table(data_ttest_sum, file = "comparisons_human_pipeline_Level_1_t_test.txt", append = FALSE, row.names = FALSE, col.names = TRUE, sep='\t')
  }
if (length(levels(file$pipeline)) != 2){
  warning("You don't have two groups")} else if (exists('data_wil_sum') == TRUE){
    data_wil_sum[,3] <- p.adjust(data_wil_sum[,3], method = 'fdr')
    write.table(data_wil_sum, file = "comparisons_human_pipeline_Level_1_wilcox.txt", append = FALSE, row.names = FALSE, col.names = TRUE, sep='\t')
  }
#
#
if (length(levels(file$database)) <= 2){
  warning("You don't have more than two groups")} else if (x$p.value >= 0.05 && length(levels(file$database)) >= 3){
    tuk_res <- TukeyHSD(aov(file$count ~ file$database))
    tuk_res$`file$database`[,4] <- p.adjust(tuk_res$`file$database`[,4],method = 'fdr')
    write.table(z, file = "comparisons_human_database_Level_1_tukey.txt", append = TRUE, row.names = FALSE, col.names = FALSE, sep='\t')
    write.table(tuk_res$`file$database`, file = "comparisons_human_database_Level_1_tukey.txt", append = TRUE, row.names = TRUE, col.names = NA, sep='\t')
  } else if (x$p.value < 0.05 && length(levels(file$database)) >= 3){
    krusk_res <- kwAllPairsDunnTest(x=file$count, g=file$database, p.adjust.method="fdr")
    write.table(z, file = "comparisons_human_database_Level_1_kruskal.txt", append = TRUE, row.names = FALSE, col.names = FALSE, sep='\t')
    write.table(krusk_res$method,file = "comparisons_human_database_Level_1_kruskal.txt", append = TRUE, row.names = TRUE, col.names = TRUE, sep='\t')
    write.table(krusk_res$p.value,file = "comparisons_human_database_Level_1_kruskal.txt", append = TRUE, row.names = TRUE, col.names = NA, sep='\t')
    write.table(krusk_res$p.adjust.method,file = "comparisons_human_database_Level_1_kruskal.txt", append = TRUE, row.names = TRUE, col.names = TRUE, sep='\t')
  }
if (length(levels(file$database)) != 2){
  warning("You don't have two groups")} else if (x$p.value >= 0.05 && length(levels(file$database)) == 2){
    ttest_res <- t.test(file$count ~ file$database)
    data_info <- c(data_info, z)
    data_t <- c(data_t, ttest_res[1])
    data_fdr <- c(data_fdr, ttest_res[3])
    data_ttest_sum <- cbind(data_info, data_t, data_fdr)
    colnames(data_ttest_sum)[1:3] <- c('Data', 't_value', 'FDR')
  } else if (x$p.value < 0.05 && length(levels(file$database)) == 2){
    wilcox_res <-wilcox.test(file$count ~ file$database)
    
    data_info_wil <- c(data_info_wil, z)
    data_wil_w <- c(data_wil_w, wilcox_res[1])
    data_wil_fdr <- c(data_wil_fdr, wilcox_res[3])
    data_wil_sum <- cbind(data_info_wil, data_wil_w, data_wil_fdr)
    colnames(data_wil_sum)[1:3] <- c('Data', 'w_value', 'FDR')
}
#
if (length(levels(file$database)) != 2){
  warning("You don't have two groups")} else if (exists('data_ttest_sum') == TRUE){
    data_ttest_sum[,3] <- p.adjust(data_ttest_sum[,3], method = 'fdr')
    write.table(data_ttest_sum, file = "comparisons_human_database_Level_1_t_test.txt", append = FALSE, row.names = FALSE, col.names = TRUE, sep='\t')
  }
if (length(levels(file$database)) != 2){
  warning("You don't have two groups")} else if (exists('data_wil_sum') == TRUE){
    data_wil_sum[,3] <- p.adjust(data_wil_sum[,3], method = 'fdr')
    write.table(data_wil_sum, file = "comparisons_human_database_Level_1_wilcox.txt", append = FALSE, row.names = FALSE, col.names = TRUE, sep='\t')
  }
#
#
if (length(levels(file$U_or_V)) <= 2){
  warning("You don't have more than two groups")} else if (x$p.value >= 0.05 && length(levels(file$U_or_V)) >= 3){
    tuk_res <- TukeyHSD(aov(file$count ~ file$U_or_V))
    tuk_res$`file$U_or_V`[,4] <- p.adjust(tuk_res$`file$U_or_V`[,4],method = 'fdr')
    write.table(z, file = "comparisons_human_U_or_V_Level_1_tukey.txt", append = TRUE, row.names = FALSE, col.names = FALSE, sep='\t')
    write.table(tuk_res$`file$U_or_V`, file = "comparisons_human_U_or_V_Level_1_tukey.txt", append = TRUE, row.names = TRUE, col.names = NA, sep='\t')
  } else if (x$p.value < 0.05 && length(levels(file$U_or_V)) >= 3){
    krusk_res <- kwAllPairsDunnTest(x=file$count, g=file$U_or_V, p.adjust.method="fdr")
    write.table(z, file = "comparisons_human_U_or_V_Level_1_kruskal.txt", append = TRUE, row.names = FALSE, col.names = FALSE, sep='\t')
    write.table(krusk_res$method,file = "comparisons_human_U_or_V_Level_1_kruskal.txt", append = TRUE, row.names = TRUE, col.names = TRUE, sep='\t')
    write.table(krusk_res$p.value,file = "comparisons_human_U_or_V_Level_1_kruskal.txt", append = TRUE, row.names = TRUE, col.names = NA, sep='\t')
    write.table(krusk_res$p.adjust.method,file = "comparisons_human_U_or_V_Level_1_kruskal.txt", append = TRUE, row.names = TRUE, col.names = TRUE, sep='\t')
  }
if (length(levels(file$U_or_V)) != 2){
  warning("You don't have two groups")} else if (x$p.value >= 0.05 && length(levels(file$U_or_V)) == 2){
    ttest_res <- t.test(file$count ~ file$U_or_V)
    data_info <- c(data_info, z)
    data_t <- c(data_t, ttest_res[1])
    data_fdr <- c(data_fdr, ttest_res[3])
    data_ttest_sum <- cbind(data_info, data_t, data_fdr)
    colnames(data_ttest_sum)[1:3] <- c('Data', 't_value', 'FDR')
  } else if (x$p.value < 0.05 && length(levels(file$U_or_V)) == 2){
    wilcox_res <-wilcox.test(file$count ~ file$U_or_V)
    
    data_info_wil <- c(data_info_wil, z)
    data_wil_w <- c(data_wil_w, wilcox_res[1])
    data_wil_fdr <- c(data_wil_fdr, wilcox_res[3])
    data_wil_sum <- cbind(data_info_wil, data_wil_w, data_wil_fdr)
    colnames(data_wil_sum)[1:3] <- c('Data', 'w_value', 'FDR')
}
#
if (length(levels(file$U_or_V)) != 2){
  warning("You don't have two groups")} else if (exists('data_ttest_sum') == TRUE){
    data_ttest_sum[,3] <- p.adjust(data_ttest_sum[,3], method = 'fdr')
    write.table(data_ttest_sum, file = "comparisons_human_U_or_V_Level_1_t_test.txt", append = FALSE, row.names = FALSE, col.names = TRUE, sep='\t')
  }
if (length(levels(file$U_or_V)) != 2){
  warning("You don't have two groups")} else if (exists('data_wil_sum') == TRUE){
    data_wil_sum[,3] <- p.adjust(data_wil_sum[,3], method = 'fdr')
    write.table(data_wil_sum, file = "comparisons_human_U_or_V_Level_1_wilcox.txt", append = FALSE, row.names = FALSE, col.names = TRUE, sep='\t')
  }
#
#
