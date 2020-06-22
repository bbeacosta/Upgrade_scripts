### Load packages ###
library(tidyverse)

### set working directory and load data ###
setwd("C:/Users/skgtbco/OneDrive - University College London/PhD folder/PPI Networks/WPPINA/December2019/GenePrioritisation/Targets/InSilico_Modelling/")

PPI_Targets <- read_table2("TargetsInteractome_NoPPP2CA_4superCore.txt", col_names = T)
UPS <- read_table2("Code_pathway_UPS_Supercore.txt", col_names = T)

### main ###
results <- PPI_Targets %>% 
  mutate(match = ifelse((NameA %in% UPS$UPS) &
                          (NameB %in% UPS$UPS), 
                        TRUE, FALSE)) %>% 
  filter(match) %>% 
  select(NameA, NameB)

### save ###
write_csv(results, "SuperCore_UPS_Cytoscape.csv")
