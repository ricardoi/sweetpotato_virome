#'@title:  "Bipartite networks of results: seven regions of sweetpotato in Africa??"
#'@author: "R Alcala"
#'@date:   "07/02/2021"
#'@output: "Metadata"
#'
unlink(".RData")
setwd("../../../ricar/Dropbox (UFL)/Alcala_Briseno-Garrett/+++Sweetpotato_virome/+Sweetpotato_virome/")
#---- Libraries ----
library("tidyverse")
library(plyr)
library(viridis)
library(scales)


#---- Loading data as :: list
files = list.files(pattern="*_ll.csv")
files
#
ls = list(NULL)
for (i in seq_along(files)){
  x <- read.csv(files[i], as.is=T)
  x$IDs <- rep(strsplit(files[i], "_")[[1]][1], nrow(x))
  ls[[i]] = x
}

#-- For viruses 
# counting the top 10
top10viruses <- rbind(ls[[1]][1:10,1:2],
         ls[[2]][1:10,1:2],
         ls[[3]][1:10,1:2],
         ls[[4]][1:10,1:2],
         ls[[5]][1:10,1:2],
         ls[[6]][1:10,1:2],
         ls[[7]][1:10,1:2])
top10virus <- sort(table(top10viruses$Virus), decreasing = T)[1:10]
top10virus

# counting node degree of viruses
nd.viruses <- rbind(ls[[1]][1:10,c(1,2)],
                      ls[[2]][1:10,c(1,2)],
                      ls[[3]][1:10,c(1,2)],
                      ls[[4]][1:10,c(1,2)],
                      ls[[5]][1:10,c(1,2)],
                      ls[[6]][1:10,c(1,2)],
                      ls[[7]][1:10,c(1,2)])
nd.virus <- nd.viruses %>%
  group_by(Virus) %>%
  summarise_at(vars(degree), list(name = mean))    
nd.virus.sum<- sort(nd.virus, decreasing = T)



# counting betweenness of viruses
betw.viruses <- rbind(ls[[1]][1:10,c(1,13)],
                      ls[[2]][1:10,c(1,13)],
                      ls[[3]][1:10,c(1,13)],
                      ls[[4]][1:10,c(1,13)],
                      ls[[5]][1:10,c(1,13)],
                      ls[[6]][1:10,c(1,13)],
                      ls[[7]][1:10,c(1,13)])
betw.virus <- betw.viruses %>%
  group_by(Virus) %>%
  summarise_at(vars(weighted.betweenness), list(name = mean))    
betw.virus.sum<- sort(betw.virus, decreasing = T)


#NOTES
# apply Thau and other comparison between the 7 networks.


#--- Get the means of node degree, etc... 
nodedegree=list()
for (i in seq_along(ls)){
  nodedegree[[i]] <- ls[[i]][2]
}
nodedegree.mean = mean(unlist(nodedegree))
nodedegree.var = var(unlist(nodedegree))
nodedegree.sd = sd(unlist(nodedegree))
# by region
# 1
regions.nd = list()
for (i in seq_along(ls)){
  regions.nd[[i]] <- c(mean1 <-  mean(unlist(ls[[i]][2])),
                     sd1 <-  sd(unlist(ls[[i]][2])),
                     var1 <-  var(unlist(ls[[i]][2])))
}
regions.nds=unlist(regions.nd)
regions.nds <- round(matrix(regions.nds, ncol = 3,byrow = 7), 2)
colnames(regions.nds) <- c("mean", "std.dev", "var")
rownames(regions.nds) <- seq_along(ls)
regions.nds

#     mean  std.dev  var
# 1 100.16   34.66   1201.03
# 2  22.28    5.43   29.47
# 3  67.68   32.76   1073.54
# 4 118.68   52.53   2759.65
# 5  83.14   27.92   779.65
# 6  99.28   44.74   2001.98
# 7  71.73   41.48   1720.59


#---- subset the list by region and print summary
(reg1 <- lapply(ls[[1]], summary))
(reg2 <- lapply(ls[[2]], summary))
(reg3 <- lapply(ls[[3]], summary))
(reg4 <- lapply(ls[[4]], summary))
(reg5 <- lapply(ls[[5]], summary))
(reg6 <- lapply(ls[[6]], summary))
(reg7 <- lapply(ls[[7]], summary))


#---- For virus
res.nd <-c(reg1[2],
           reg2[2],
           reg3[2],
           reg4[2],
           reg5[2],
           reg6[2],
           reg7[2])
res.nds <- matrix(unlist(res.nd), nrow = 6)
rownames(res.nds) <- names(res.nd[[1]])
colnames(res.nds)<- 1:ncol(res.nds)
round(t(res.nds), 2)
# Node degree
# Region  Min.  1st Qu.  Median  Mean   3rd Qu.  Max. 
# 1       21    76.0     106.0   100.2  131.0    144 
# 2       10    19.00    24.00   22.28  26.00    30 
# 3       12    41.75    65.50   67.68  99.00    116 
# 4       18    83.5     112.0   118.7  173.0    184 
# 5       20    61.00    92.00   83.14  110.00   119 
# 6       9     63.00    97.00   99.28  144.00   164 
# 7       5     44.00    70.50   71.73  91.75    146 

#--
res.ss <-c(reg1["species.strength"],
           reg2["species.strength"],
           reg3["species.strength"],
           reg4["species.strength"],
           reg5["species.strength"],
           reg6["species.strength"],
           reg7["species.strength"])
res.sps <- matrix(unlist(res.ss), nrow = 6)
rownames(res.sps) <- names(res.ss[[1]])
colnames(res.sps)<- 1:ncol(res.sps)
round(t(res.sps), 2)
# Species strenght
# summary
#   Min. 1st Qu. Median Mean 3rd Qu. Max.
# 1 0.50    1.61   2.18 2.13    2.40 3.78
# 2 0.40    0.68   0.85 0.79    0.92 1.01
# 3 0.39    1.29   2.14 2.30    3.31 6.19
# 4 0.46    1.93   2.84 2.71    3.79 4.31
# 5 0.39    1.36   2.02 1.79    2.23 2.83
# 6 0.43    2.02   2.90 2.91    3.69 5.44
# 7 0.17    1.02   2.28 2.87    4.44 8.17

# by Species 
ss.reg1<- ls[[1]]
ss.reg1=ss.reg1[with(ss.reg1, order(ss.reg1$species.strength, decreasing = T)),]
 plot(ss.reg1$species.strength)

ss.reg=list()
for (i in seq_along(ls)){
  ss.reg[[i]]<- ls[[i]]
  ss.reg[[i]]=ss.reg[[i]][with(ss.reg[[i]], order(ss.reg[[i]]$species.strength, decreasing = T)),]
}

ls.regs <- bind_rows(ls[[1]], ls[[2]], ls[[3]], ls[[4]], 
                      ls[[5]], ls[[6]], ls[[7]])

ggplot(ls.regs, aes(y = species.specificity.index, x = species.strength)) +
  geom_point(aes(color = IDs), alpha = 0.6, size = 3) +
  geom_smooth(method = lm,  aes( color=IDs),
              # col = "#C42126",
              se = F,
              size = 1)+
  geom_text(aes(label=ifelse(species.specificity.index > 0.5 | species.strength > 2, Virus, '')))+
  facet_wrap(IDs~.)+
  theme_classic()


 plot(ss.reg[[1]]$species.specificity.index ~ss.reg[[1]]$species.strength, xlim = c(0,5), ylim = c(0,1))
points(ss.reg[[2]]$species.specificity.index ~ ss.reg[[2]]$species.strength, col="red")
points(ss.reg[[3]]$species.specificity.index ~ ss.reg[[3]]$species.strength, col="green")
points(ss.reg[[4]]$species.specificity.index ~ ss.reg[[4]]$species.strength, col="purple")
points(ss.reg[[5]]$species.specificity.index ~ ss.reg[[5]]$species.strength, col="blue")
points(ss.reg[[6]]$species.specificity.index ~ ss.reg[[6]]$species.strength, col="pink")
points(ss.reg[[7]]$species.specificity.index ~ ss.reg[[7]]$species.strength, col="cyan")

lm(ss.reg[[1]]$species.specificity.index ~ss.reg[[1]]$species.strength)


res.ssi <-c(reg1["species.specificity.index"],
           reg2["species.specificity.index"],
           reg3["species.specificity.index"],
           reg4["species.specificity.index"],
           reg5["species.specificity.index"],
           reg6["species.specificity.index"],
           reg7["species.specificity.index"])
res.spsi <- matrix(unlist(res.ssi), nrow = 6)
rownames(res.spsi) <- names(res.ssi[[1]])
colnames(res.spsi)<- 1:ncol(res.sps)
round(t(res.spsi), 2)
# Species specificity index
# Summary
#   Min. 1st Qu. Median Mean 3rd Qu. Max.
# 1 0.09    0.12   0.16 0.17    0.20 0.35
# 2 0.18    0.26   0.32 0.35    0.41 0.65
# 3 0.14    0.22   0.26 0.30    0.36 0.85
# 4 0.11    0.14   0.18 0.20    0.23 0.50
# 5 0.10    0.15   0.19 0.21    0.25 0.42
# 6 0.12    0.17   0.22 0.27    0.28 0.98
# 7 0.13    0.19   0.24 0.33    0.44 0.86
 


#--
res.Fa <-c(reg1["Fisher.alpha"],
           reg2["Fisher.alpha"],
           reg3["Fisher.alpha"],
           reg4["Fisher.alpha"],
           reg5["Fisher.alpha"],
           reg6["Fisher.alpha"],
           reg7["Fisher.alpha"])
res.Fas <- matrix(unlist(res.Fa), nrow = 6)
rownames(res.Fas) <- names(res.Fa[[1]])
colnames(res.Fas)<- 1:ncol(res.Fas)
round(t(res.Fas), 2)
# Fisher alpha
# Min. 1st Qu. Median  Mean 3rd Qu.  Max.
# 1  8.73   33.21  47.59 44.56   57.05 73.74
# 2  3.30    6.72   7.85  7.70    9.17 11.99
# 3  3.19   14.34  20.60 20.18   26.68 33.20
# 4  7.41   36.30  47.81 48.64   67.83 78.39
# 5 11.96   28.24  38.03 37.04   47.13 56.14
# 6  1.52   22.98  33.99 31.76   42.43 55.39
# 7  1.24   12.18  17.75 20.41   28.52 41.97

#--
res.be <-c(reg1["weighted.betweenness"],
           reg2["weighted.betweenness"],
           reg3["weighted.betweenness"],
           reg4["weighted.betweenness"],
           reg5["weighted.betweenness"],
           reg6["weighted.betweenness"],
           reg7["weighted.betweenness"])
res.bet <- matrix(unlist(res.be), nrow = 6)
rownames(res.bet) <- names(res.be[[1]])
colnames(res.bet)<- 1:ncol(res.bet)
round(t(res.bet), 3)
# Betweenness
# Min. 1st Qu. Median  Mean 3rd Qu.  Max.
# 1 0.000   0.000  0.000 0.000   0.000 0.000
# 2 0.000   0.000  0.000 0.000   0.000 0.000
# 3 0.009   0.018  0.018 0.017   0.018 0.018
# 4 0.000   0.000  0.000 0.000   0.000 0.000
# 5 0.000   0.000  0.000 0.000   0.000 0.000
# 6 0.003   0.017  0.017 0.015   0.017 0.017
# 7 0.000   0.002  0.029 0.019   0.029 0.029
# # w betweenness
# Min. 1st Qu. Median  Mean 3rd Qu.  Max.
# 1    0       0      0 0.013   0.000 0.549
# 2    0       0      0 0.026   0.017 0.199
# 3    0       0      0 0.017   0.011 0.198
# 4    0       0      0 0.013   0.014 0.127
# 5    0       0      0 0.013   0.009 0.293
# 6    0       0      0 0.015   0.006 0.247
# 7    0       0      0 0.019   0.025 0.219

#---- For host ----
res.ed <-c(reg1["partner.diversity"],
           reg2["partner.diversity"],
           reg3["partner.diversity"],
           reg4["partner.diversity"],
           reg5["partner.diversity"],
           reg6["partner.diversity"],
           reg7["partner.diversity"])
res.eds <- matrix(unlist(res.ed), nrow = 6)
rownames(res.eds) <- names(res.ed[[1]])
colnames(res.eds)<- 1:ncol(res.eds)
round(t(res.eds), 2)




#x=6
gg=list()
for (x in seq_along(ls)){
  ls[[x]]$degree <- as.numeric(as.character(ls[[x]]$degree))
print(paste("Printing :: Region", x, "of the sweetpotato virome", sep= " "))
pdf(paste("Region", x, "of the sweetpotato virome", format(Sys.time(), "%b%d"), ".pdf", sep= "_"),
      width = 15, # The width of the plot in inches
      height = 15) # The height of the plot in inches
gg[[x]] <- ggplot(ls[[x]], aes(x = (nestedrank-1)*-1, y = degree))+
  geom_count(aes(col = Virus, size = species.strength))+
  # geom_smooth(method = "loess", se = F) + 
  labs(subtitle="Nested rank Vs node degree", 
       y="Node degree", 
       x="Inv. nested rank", 
       title=paste("Region", x, "of the sweetpotato virome", sep= " "))+
  theme_bw()
plot(gg[[x]])
dev.off()
}
#---



options(scipen=999)  # turn-off scientific notation like 1e+48
theme_set(theme_bw())  # pre-set the bw theme.
data("midwest", package = "ggplot2")
# midwest <- read.csv("http://goo.gl/G1K41K")  # bkup data source

# Scatterplot
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state, size=popdensity)) + 
  geom_smooth(method="loess", se=F) + 
  xlim(c(0, 0.1)) + 
  ylim(c(0, 500000)) + 
  labs(subtitle="Area Vs Population", 
       y="Population", 
       x="Area", 
       title="Scatterplot", 
       caption = "Source: midwest")
