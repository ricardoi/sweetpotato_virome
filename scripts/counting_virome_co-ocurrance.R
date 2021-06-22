#'@title:  "Counting virome species"
#'@author: "R Alcala"
#'@date:   "05/01/2021"
#'@output: "Stats"
#---------------------------- species co-occurrence --------------------------- 
# NECESITO CARGAR EL NUEVO DATOS 0-KCLUSTER...
#----------------- Install & load libraries ------------------
library(tidyverse)
library(dplyr)
library(plyr)
library(igraph )
#### NOTE
# k1vina comes from the script ViNAbn_v2.hpg.R

virome <- ddply(kvina, .(IDs, Family, Genus, Acronym, cluster), 
                     summarise, Coverage=mean(RPKM_mean))
length(unique(virome$IDs))
table(kvina$cluster)
# virome counts
vir <- as_tibble(ddply(virome, .(IDs, cluster), summarise, cov = mean(Coverage)))

# Example
# Histogram on a Categorical variable
ggplot(vir, aes(cluster))+ 
  geom_bar(aes(fill=cluster), width = 0.5) + 
  theme(axis.text.x = element_text(angle=65, vjust=1)) + 
  labs(title="Histogram on Categorical Variable", 
       subtitle="Virome Composition across Sweepotato Cluster") 

# c("red", "yellow", "purple", "blue", "orange", "pink","black")
##############



vir <-  tidyr::spread(vir, IDs, cov, drop=T, fill = 0)
rownames(vir) <- vir$Acronym
vir <- vir[-c(1)]
n=length(vir)
vir[1:5, 1:5]
paste("MESSAGE:: The lenght of the sample locations is ", length(vir), " and the data matrix is ", n,
      ", then dimesions are equal? A = ", length(unique(virome$IDs)) == length(vir), sep = "")

virgraph <- graph_from_data_frame(vir, directed = F )

plot(g)


# virome0 <- as_tibble(ddply(virome, .(IDs, Acronym, cluster), summarise, Cov= Coverage/Coverage))
# table(virome0$IDs)
# table(virome$IDs, virome$cluster)

#virome0 <- as_tibble(ddply(kvina, .(IDs, Acronym, cluster), summarise, Cov= RPKM_mean/RPKM_mean))
#virome0

#virome <-  as_tibble(ddply(virome0, .(IDs, Acronym, cluster), summarise, count= (Cov)))
#virome

ggplot(virome0, aes(cluster))+
        geom_bar(aes(fill=Acronym))

#virome0=viromeReads[viromeReads$Coverage > 1,]
#IDs.mastre <- virome0$IDs[virome0$Acronym == "SPSMV-1"] 
#mastre.0 <- virome0[which(virome0$IDs %in% IDs.mastre), ]
# table(mastre.0$Acronym)
# plotting incidence
# pdf("SSA-SPV_all_incidence.pdf", width = 15, height = 30)
# par(mfrow=c(4,2), mar=c(8,8,8,8))
# All
plot(sort(table(virome$IDs), decreasing = T), las= 2, cex.axis = 0.5,lwd=5,
     ylim=c(0,1350), ylab = "Virus Incidence", main="SSA-SPV virus incidence")
abline(h=50, col = "red")
# cluster 1
plot(sort(table(virome0[which(virome0$cluster==1),]$Species), decreasing = T), las= 2, cex.axis = 0.5,lwd=5,
     ylim=c(0,228), ylab = "Virus Incidence", main="SSA-SPV virus incidence")
abline(h=50, col = "red")
# cluster 2
plot(sort(table(virome0[which(virome0$cluster==2),]$Species), decreasing = T), las= 2, cex.axis = 0.5,lwd=5,
     ylim=c(0,36), ylab = "Virus Incidence", main="SSA-SPV virus incidence")
abline(h=50, col = "red")
# cluster 3
plot(sort(table(virome0[which(virome0$cluster==3),]$Species), decreasing = T), las= 2, cex.axis = 0.5,lwd=5,
     ylim=c(0,171), ylab = "Virus Incidence", main="SSA-SPV virus incidence")
abline(h=50, col = "red")
# cluster 4
plot(sort(table(virome0[which(virome0$cluster==4),]$Species), decreasing = T), las= 2, cex.axis = 0.5,lwd=5,
     ylim=c(0,262), ylab = "Virus Incidence", main="SSA-SPV virus incidence")
abline(h=50, col = "red")
# cluster 5
plot(sort(table(virome0[which(virome0$cluster==5),]$Species), decreasing = T), las= 2, cex.axis = 0.5,lwd=5,
     ylim=c(0,151), ylab = "Virus Incidence", main="SSA-SPV virus incidence")
abline(h=50, col = "red")
# cluster 6
plot(sort(table(virome0[which(virome0$cluster==6),]$Species), decreasing = T), las= 2, cex.axis = 0.5,lwd=5,
     ylim=c(0,261), ylab = "Virus Incidence", main="SSA-SPV virus incidence")
abline(h=50, col = "red")
# cluster 7
plot(sort(table(virome0[which(virome0$cluster==7),]$Species), decreasing = T), las= 2, cex.axis = 0.5,lwd=5,
     ylim=c(0,500), ylab = "Virus Incidence", main="SSA-SPV virus incidence")
abline(h=50, col = "red")
# dev.off()

bin = table(virome0$IDs, virome0$Acronym)


pair1 <- bin[,c("SPFMV", "SPCSV", "SPLCV", "SPSMV-1")]
pair1 <- data.frame(SPFMV=pair1[,1], SPCSV=pair1[,2], SPLVC=pair1[,3], SPSMV=pair1[,4])
pair1$mixed <- apply(pair1, 1, sum)
table(pair1$mixed)

distribution <- sort(table(virome0$Acronym), decreasing = T)
distribution[1] <- distribution[1]/2
plot(distribution, las = 2)

pair1 <- bin[,c("SPFMV", "SPCSV", "SPLCV", "SPSMV-1", "BYMV")]
pair1 <- data.frame(SPFMV=pair1[,1], SPCSV=pair1[,2], SPLVC=pair1[,3], SPSMV=pair1[,4], BYMV=pair1[,5])
pair1$mixed <- apply(pair1, 1, sum)
table(pair1$mixed)


pair1 <- bin[,c("SPPV", "CmV", "SPFMV", "SPSMV-1", "SPCSV", "SPVG", "SPLCV", "SPV2", "SPVC")]

pair1 <- data.frame(SPPV=pair1[,1], CmV=pair1[,2], SPFMV=pair1[,3], SPSMV=pair1[,4], SPCSV=pair1[,5],
                    SPLVC=pair1[,6], SPV2=pair1[,7], SPVC=pair1[,8])
pair1$mixed <- apply(pair1, 1, sum)
table(pair1$mixed)

