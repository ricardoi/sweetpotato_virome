


library("tidyverse")
library(plyr)
library("CommEcol")
library("bipartite")
library("igraph")
library(viridis)
library(scales)

setwd("Alcala_Briseno-Garrett/+++Sweetpotato_virome/+Sweetpotato_virome/")


# Read data from ViNA
 virome <- read.csv("aswp_virome_vina_kcluster-Mar03.csv", header = T, stringsAsFactors = F)

as_tibble(virome)
virome1 <- ddply(virome, .(Acronym, cluster), summarise, Coverage=mean(RPKM_mean))
virome.m <- tidyr::spread(virome1, cluster, Coverage,  drop=TRUE , fill = 0)
rownames(virome.m) <- virome.m$Acronym
datm <- virome.m[-c(1)]
n=length(datm)


virome = t(datm)
# virome <-  graph.incidence(dat.mat, weighted=T)
simi<-autosimi(virome, binary=T, permutations=100)
simi
plot(simi, ylim=c(0.5,1)) # maintain the plot window open for the next curve
simi.log<-autosimi(virome, binary=T, log.transf=F, permutations=100)
points(simi.log, col="red")


# grad <- 1:nrow(virome)

b.resu <- betaRegDisp(y = virome, x = grad, xy.coord = NULL, ws = 3,
                      method.1 = "bray",
                      method.2 = "ruzicka",
                      method.3 = "ruzicka",
                      independent.data = FALSE, illust.plot = FALSE)

op <- par(no.readonly = TRUE)
par(mfrow = c(5, 2), oma = c(1, 0, 1, 0.1), mar = c(1.5, 3, .1, .1), cex = 1, las = 0)
for(i in 1:ncol(b.resu)){
  plot(b.resu[, 1], b.resu[, i], ylab = colnames(b.resu)[i], cex.lab = .9,
       cex.axis = 0.9, tcl = -0.2, mgp = c(1.5, .2, 0), pch = 15, col = "grey")
}
mtext("Sweetpotato populations", cex = 1.3, 1, -0.1, outer = TRUE)
par(op)

#----

dis.chao(virome, index="jaccard", version="probability", freq=NULL)


virome.goodall <- dis.goodall(virome, p.simi="gower", approach="proportion")


dim(as.matrix(virome.goodall))
goodall <- melt(as.matrix(virome.goodall), na.rm = TRUE)

#function
reorder_virdat <- function(virome_data){
  # Use correlation between variables as distance
  dd <- as.dist((1-virome_data)/2)
  hc <- hclust(dd)
  cormat <-cormat[hc$order, hc$order]
}

cormat <- reorder_virdat(as.matrix(virome.goodall))
upper_tri <- get_upper_tri(cormat)

# Heatmap
library(ggplot2)
ggplot(data = goodall, aes(Var2, Var1, fill = value))+
  geom_tile(color = "white")+
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1,1), space = "Lab", 
                       name="Goodalll\nIndex") +
  theme_minimal()+ 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, 
                                   size = 12, hjust = 1))+
  coord_fixed()



#-------------------------------------------------------------------------------
#-----------

##### loading list of bipartite graph
files = list.files(pattern="*_ll.csv")
files
#
ls = list(NULL)
for (i in seq_along(files)){
  x <- read.csv(files[i], as.is=T)
  x$IDs <- rep(strsplit(files[i], "_")[[1]][1], nrow(x))
  ls[[i]] = x
}
ls[[1]]

# merged.data.frame <-  Reduce(function(...) merge(..., all=T), ls)

meta.comm <- rbind.fill(ls) 
summar(meta.comm)
fromto <- ddply(meta.comm, .(Virus, IDs), summarise, metric=mean(species.strength))
comm.mat <- tidyr::spread(fromto, IDs, metric,  drop=TRUE , fill = 0)

rownames(comm.mat) <- comm.mat$Virus
comm.m <- comm.mat[-c(1)]
(n=length(comm.m))

# dat.mat = round(comm.mat, digits = 0)
dim(comm.m)

plotweb(sortweb(comm.m, sort.order="inc"), method="normal")   
visweb(sortweb(comm.m,sort.order="inc"), type="diagonal", labsize=3,
             square="interaction", text="none", textsize = 4,circles=FALSE, frame=FALSE)#




data(BCI)
BCI
simi<-autosimi(BCI, binary=TRUE, permutations=5)
simi
plot(simi, ylim=c(0.5,1)) # maintain the plot window open for the next curve
simi.log<-autosimi(BCI, binary=FALSE, log.transf=TRUE, permutations=5)
points(simi.log, col="red")

#------- Network


source("/Users/ricardoi/Documents/Documents-ehecatl/git_db/scripts_r/bipartite_package/weighted-modularity-LPAwbPLUS-master/code/R/convert2moduleWeb.R")
source("/Users/ricardoi/Documents/Documents-ehecatl/git_db/scripts_r/bipartite_package/weighted-modularity-LPAwbPLUS-master/code/R/GetModularInformation.R")
source("/Users/ricardoi/Documents/Documents-ehecatl/git_db/scripts_r/bipartite_package/weighted-modularity-LPAwbPLUS-master/code/R/LPA_wb_plus.R")
source("/Users/ricardoi/Documents/Documents-ehecatl/git_db/scripts_r/bipartite_package/weighted-modularity-LPAwbPLUS-master/code/R/MODULARPLOT.R")

# Degree distribution: fitting to a linear, power law and truncayed power law distribution 
degreedistr(dat.mat)
nested(dat.mat, method="wine")

# Rarest species first:
visweb(sortweb(dat.mat,sort.order="inc"), type="diagonal", labsize=3,
       square="interaction", text="none", textsize = 4,circles=FALSE, frame=FALSE)
# Modularity
#example scripts
# MOD1 = LPA_wb_plus(as.matrix(dat.mat)) # find labels and weighted modularity using LPAwb+
MOD2 = DIRT_LPA_wb_plus(as.matrix(dat.mat)) # find labels and weighted modularity using DIRTLPAwb+
# MOD3 = DIRT_LPA_wb_plus(as.matrix(dat.mat) > 0, 2, 20) # find labels and binary modularity using DIRTLPAwb+ checking from a minimum of 2 modules and 20 replicates

MODULARPLOT(dat.mat, MOD1) 
MODULARPLOT(dat.mat, MOD2) # THIS
MODULARPLOT(dat.mat, MOD3) 

# module Web
Mod1modWeb <- convert2moduleWeb(as.matrix(dat.mat), mod2)
plotModuleWeb(Mod1modWeb, weighted = T)


MOD1information = GetModularInformation(dat.mat, MOD2)
print(MOD1information$normalised_modularity)  # normalised modularity score for configuration found by MOD1 for MAT
print(MOD1information$realized_modularity)  # realized modularity score for configuration found by MOD1 for MAT
print(MOD1information$RowNodesInModules)  # Shows row nodes per module
print(MOD1information$ColNodesInModules)  # Shows column nodes per module




# Prepraring colors
a <- rowSums(dat.mat)
snode <- data.frame(Species=names(a), Coverage=as.integer(a)) #normalized RPKMs
snodes = rbind(snode, data.frame(Species=rep("nodes", n), Coverage=rep(25, n)))
# aading attributes
V(virome)$type
V(virome)$name <- c(V(virome)$name[1:length(V(virome)$type[V(virome)$type == "FALSE"])],
                    rep("", length(V(virome)$type[V(virome)$type == "TRUE"])))

V(virome)$color <-  c(rep("yellow", length(V(virome)$type[V(virome)$type == "FALSE"])), rep("green", length(V(virome)$type[V(virome)$type == "TRUE"])))
V(virome)$xx <- log(snodes$Coverage) # coverage size
# V(virome)$width <- c((datb.sp.table$`lower level`$species.strength)+6, log(datb.sp.table$`higher level`$degree)+2)
show_col(unique(V(virome)$color))
# 
# submeta <- meta[which(meta$SampleID %in% colnames(dat.mat)),]
# legend <- unique(cbind(ColorCode=submeta$colors, Region=as.character(submeta$Country)))
# Edges names and attributes
rbPal <- colorRampPalette(c("#f5f5f5", "#483C33")) 
# rbPal <- colorRampPalette(c("yellow", "red3")) 

E(virome)$width <- (E(virome)$weight)
# E(virome)$width[E(virome)$width <= 1] <- NA
# E(virome)$width <- log2(E(virome)$width)
# E(virome)$width[E(virome)$width == 0] <- NA
# E(virome)$width <- (E(virome)$width)/max(E(virome)$width[!is.na(E(virome)$width)])
# E(virome)$color <- rbPal(4)[as.numeric(cut(E(virome)$width, breaks = 4))]

# E(virome)$color <- rbPal(10)[as.numeric(cut(E(virome)$width, breaks = 10))]
shapes = c(rep("circle", length(V(virome)$type[V(virome)$type == "FALSE"])), rep("square", length(V(virome)$type[V(virome)$type == "TRUE"])))
# # Network

plot(virome, edge.arrow.size=1, vertex.shape=shapes, vertex.size=V(virome)$width , 
     vertex.label.cex=1, vertex.label.color='black', vertex.frame.color="gray", 
     vertex.frame.color="gold",   edge.curved=F,  layout=layout_with_kk(virome))  


rcPal <- colorRampPalette(c( "skyblue", "lightgreen",  "orange", "#B03060", "#FFD700", "orangered1")) 


dat.mat
# Projection One mode 
vg <- bipartite.projection(virome)

vgnodes <- as.list(V(vg$proj1))
V(vg$proj1)$color <- rcPal(14)[as.numeric(cut(as.numeric(factor(as.character(vgnodes))), breaks = 14))]
# Edges names and attributes
# E(vg$proj1)$color <- rgPal(10)[as.numeric(cut(E(vg$proj1)$weight, breaks = 10))]
vg.adj <- get.adjacency(vg$proj1,sparse=FALSE,attr="weight")
plot(vg$proj1,edge.width=E(vg$proj1)$weight^2, vertex.label=V(vg$proj1)$name, 
     layout=layout_with_drl(virome, dim = 3))

vg.adj1 <- get.adjacency(vg$proj1, sparse=FALSE, attr="weight")


# ‘adegenet’
# adephylo’
# adespatial’
