### Load libraries
library(ggplot2)
library(tidyverse)
library(readxl)
library(dplyr)
library(stringr)

### Set workin directory and load files ###

setwd("C:/Users/skgtbco/OneDrive - University College London/PhD folder/PPI Networks/WPPINA/December2019/GenePrioritisation/Targets/")
getwd()

df <- read_excel(path = "Targets_HeatMap.xlsx", col_names = T)

# theme and style

theme_bc <-  theme_bw(base_family = "Helvetica") + 
  theme(panel.grid.major.x = element_blank(),
        legend.position = "right",
        strip.text = element_text(size = 7),
        axis.text.x = element_text(size = 7, angle = 90, hjust = 1, vjust = 0.5),
        axis.text.y = element_text(size = 7),
        axis.title.y = element_text(vjust = 0.6),
        axis.title = element_text(size = 10),
        panel.spacing = unit(0.1, "lines"))

# Data wrangling and plotting 
df %>% 
  dplyr::group_by(Analysis.Module, Semantic.classes) %>% 
  dplyr::summarise(n = n()) %>% 
  ggplot(aes(x = Semantic.classes, y = Analysis.Module)) +
  geom_tile(aes(fill = n), colour = "black") +    
  # facet_grid(rows = vars(Semantic.classes), scales = "free_y", space = "free_y") +
  scale_fill_viridis_c(na.value = "grey") +
  labs(x = "Biological Process", y = "Module") +
  theme_bc + 
  theme(panel.grid = element_blank(),
        strip.text.y = element_text(size = 8, angle = 0))
