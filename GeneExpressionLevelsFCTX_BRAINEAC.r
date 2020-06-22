
# install.packages("read.table")

### Load packages ###
library(tidyverse)
library(read.table)

### set wd and load files ###
load("C:/Users/skgtbco/OneDrive - University College London/PhD folder/PPI Networks/WPPINA/December2019/GenePrioritisation/BRAINEAC/Data/expr.maps.rda")
setwd("C:/Users/skgtbco/OneDrive - University College London/PhD folder/PPI Networks/WPPINA/December2019/GenePrioritisation/Data/")
expr_data_BRAINEAC <- read_table2("FCTX_Braineac_tID1.txt")
genelist <- read_table2("BCosta_FTDGenesList.txt")
gene_tID_match <- read_table2("Gene_tID_match.txt")

### main ###
# convert column1 of "expr_data_BRAINEAC" to character vector in order to be able to join it to df
# df2 <- expr_data_BRAINEAC %>%  
#   mutate(tID = as.character(tID))

# df <- inner_join(t.map, genelist, by = "Symbol.NA31", copy = T) %>% 
#   inner_join(., expr.map, by = "tID", copy = T) %>% 
#   inner_join(., df2, by = "exprID", copy = T)

# partial match
test <- t.map %>%
  filter(str_detect(Symbol.NA31, pattern = str_c(genelist$Symbol.NA31, collapse = "|"))) 

test1 <-inner_join(expr_data_BRAINEAC, gene_tID_match, by = "tID", copy = T) 
  

### save results ###
# write.csv(test1, "ExpressionDataFCTX_BRAINEAC.csv")
write.table(test1, "Final_FCTX_BRAINEAC.txt")
