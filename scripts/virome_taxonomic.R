#'@title:  "Virome Taxonomy"
#'@author: "R Alcala"
#'@date:   "07/01/2021"
#'@output: "Alluvial plots"
#---------------------------- virome network metrics  --------------------------- 
setwd("~/git_local/sweetpotato_virome/data/")

#----- libraries 
library(tidyverse)

#------ reading data
virome <- read.csv("aswp_virome_vina_kcluster-Mar03.csv", as.is = T)
virome$Family <- gsub("^ ", "", virome$Family)
virome$Genus <- gsub("^ ", "", virome$Genus)
virome$Species <- gsub("^ ", "", virome$Species)
virome$pSpecies <- gsub("^ ", "", virome$pSpecies)
as_tibble(virome)

virtaxa <- virome %>% 
              select("IDs", "Family", "Genus", "pSpecies", "Acronym", "cluster", "Reads_mean") %>% 
              as_tibble()

virtaxa 
#       Generating alluvial plots
# load libraries
library(alluvial)
library(reshape2)

# adding colors
# RbPal <- rainbow(c(length(unique(virtaxa$Family))+2))
colPal <- c("orange", "firebrick", "dodgeRblue", "green1", "brown1", "cyan2", 
            "chocolate4", "bisque2", "darkmagenta", "red2", "yellowgreen")

virtaxac <- virtaxa %>%
  mutate( ss = paste(Family),
          cols = colPal[ match(ss, sort(unique(ss))) ] 
  )
virtaxac

#alluvla plot 
alluvial(virtaxac[,c(2,3,5,6)], freq=virtaxac$Reads_mean,
         #hide = datc$length == 0,
         col = virtaxac$cols,
         border = virtaxac$cols, 
         alpha = 0.7,
         blocks = FALSE,
         ordering = list(NULL, NULL, order(as.factor(virtaxac$Family)), NULL), 
         # change NULL to order them
         cex =0.8
  )


