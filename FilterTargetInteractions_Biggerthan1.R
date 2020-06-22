### load packages ###
library(tidyverse)

### load files and set directory ###
setwd("C:/Users/skgtbco/OneDrive - University College London/PhD folder/PPI Networks/WPPINA/December2019/GenePrioritisation/")
targets_core <- read_table2("Targets_coreRinput.txt")


### main ###
# count <- table(unlist(targets_core)) 

results <- targets_core %>%
  distinct(NameA, NameB) %>% 
  gather(key = variable, value = gene) %>%
  group_by(gene) %>%
  summarize(count = n()) %>% 
  filter(count > 1)

 

finalfinal <- targets_core %>% 
  filter(NameA %in% results$gene & NameB %in% results$gene)


### save ###
write_csv(finalfinal, "Targets_CoreNetwork_CytoscapeInput.csv")


# %>%
#   mutate(prop = prop.table(count),
#          perc = sub("0\\.(\\d{2})\\d+", "\\1%", prop))

# final <- subset(results, !count == 1) ### or you could use '!='
# 
# to_remove <- subset(results, count == 1)

