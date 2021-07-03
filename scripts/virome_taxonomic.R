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
              select("IDs", "Family", "Genus", "pSpecies", "Acronym", "cluster", "RPKM_mean") %>% 
              as_tibble()

virtaxa 
#       Generating alluvial plots
# load libraries
library(alluvial)
library(reshape2)

# adding colors
# RbPal <- rainbow(c(length(unique(virtaxa$Family))+2))
colPal <- c("orange", "gold", "green4", "green1", "dodgerblue", "cyan2", 
            "chocolate4", "firebrick", "darkmagenta", "red2", "yellowgreen")

virtaxac <- virtaxa %>%
  mutate( ss = paste(Family),
          cols = colPal[ match(ss, sort(unique(ss))) ] 
  )
virtaxac

#alluvla plot 
alluvial(virtaxac[,c(2,3,4)], freq=virtaxac$RPKM_mean,
         #hide = datc$length == 0,
         col = virtaxac$cols,
         border = virtaxac$cols, 
         gap.width = 0.3,
         alpha = 0.1,
         blocks = F,
         ordering = list(NULL, order(as.factor(virtaxac$Family)), NULL), 
         # change NULL to order them
         cex =1
  )


