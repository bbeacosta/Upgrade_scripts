#### Load libraries #####
library(ggplot2)
library(tidyverse)
library(stringr)
library(RColorBrewer)
library(qdapTools)
library (dplyr)

#### Load data ####

# setwd("C:/Users/skgtbco/OneDrive - University College London/PhD folder/PPI network/GProfiler")
data <- read_excel("December2019/WGCNA/gProfiler_modules_FCTX_111219.xlsx", sheet = "gtexv6_brown")


#### Process data ####

Functional_block_summary <- data %>% 
  dplyr::select(term_id, Functional_Block) %>% ## filter what you wanna keep of your df
  dplyr::group_by(Functional_Block) %>% ## to group all th same entries belonging to same functional block
  dplyr::tally() %>% ## to count how many are there per category
  dplyr::mutate(Total = sum(n), 
                Proportion = n/Total, 
                Percent = Proportion * 100) %>% ## adds new variables --> calculate total and percentages
  print() %>%
  dplyr:: filter (! Functional_Block %in% c("general","metabolism","physiology"))

Functional_block_plot <- ggplot(Functional_block_summary, aes(x = Functional_Block, y = Percent)) +
  geom_col(aes(fill = Functional_Block), colour = "black") +
  scale_x_discrete(name = "Functional Block") +
  scale_y_continuous(name = "Percent of total") +
  # scale_fill_manual(values = brewer.pal(12,"Set3")) + ###there are not enough colours in that palette
  theme_bw() +
  theme(axis.text.x = element_text(size = 8, angle = 90, hjust = 1, vjust = 0.5),
        legend.position = "bottom")

#### Save data ####

ggsave(plot = Functional_block_plot, 
       filename = "Functional_block_gtexv6_brown.png", 
       path = "December2019/WGCNA/Plots_FunctionalBlocks/",
       width = 18, height = 7, dpi = 200)

