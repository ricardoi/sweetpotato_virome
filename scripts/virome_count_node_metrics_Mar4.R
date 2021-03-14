


setwd("../../../ricar/Dropbox (UFL)/Alcala_Briseno-Garrett/+++Sweetpotato_virome/+Sweetpotato_virome/")


library("tidyverse")
library(plyr)
library(viridis)
library(scales)


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

top10viruses <- rbind(ls[[1]][1:10,1:2],
         ls[[2]][1:10,1:2],
         ls[[3]][1:10,1:2],
         ls[[4]][1:10,1:2],
         ls[[5]][1:10,1:2],
         ls[[6]][1:10,1:2],
         ls[[7]][1:10,1:2])

top10virus <- sort(table(top10viruses$Virus), decreasing = T)[1:10]
top10virus


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
