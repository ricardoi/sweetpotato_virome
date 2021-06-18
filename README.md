# ![sweetpotatovirome](http://bioinfo.bti.cornell.edu/static/img/logo_new.jpg)
[![GitHub R package version](https://img.shields.io/github/r-package/v/ricardoi/sweetpotato_virome?label=%3A%3A&logo=R&logoColor=blue&style=plastic)](https://www.r-project.org/)
[![Follow on Twitter](http://img.shields.io/badge/twitter-%40ricardoi__-1DA1F2?labelColor=000000&logo=twitter)](https://twitter.com/ricardoi_)


# Sub-Saharan Africa Sweetpotato Virome (SSA-SPV)

Pan-African sweetpotato virome: a network analysis approach for the analysis of communities of viruses

------------------------------------------------------------------------------------------------------

## The Pan-African sweetpotato virome:

A project with Dr. Jan F. Kreuze from International Potato Center ([CIP](https://cipotato.org/)), Lima, \
and Dr. Karen A. Garrett and Ricardo I. Alcala from the department of Plant Pathology ([PLP](https://plantpath.ifas.ufl.edu/)), \
Emerging Pathogens Institute ([EPI](https://epi.ufl.edu/)) and the Food Systems Institute ([FSI](https://foodsystems.ifas.ufl.edu/)) at the [University of Florida](http://www.ufl.edu/).

The Pan-African sweetpotato virome [website](http://bioinfo.bti.cornell.edu/virome/index) serve as the repository of the Sub-Saharan\
Africa sweetpotato virome network analysis ([manuscript in prep.](http://www.pending.org)).

### Summary:

A collection of 1300 viromes of swetpotato samples collected from eleven African countries were sequenced with Illumina short reads derived from small viral RNAs. The sequences were assembled with VirusDetect followed by secondary iterations allowing the classification of viruses according to the International Committee of Taxonomy of Viruses ([ICTV](https://talk.ictvonline.org/)).
We developed a network framework for the classification of virus sequences using the maximum pairwise similarity between the viral  contigs and the Reference Sequences with similarities above the species demarcation criteria. \
The identities of each viral contig was assigned taxonomically according to the closest reference sequences. These virus species clusters were quantified using the small RNA reads using RPKM quantification (). \

$\displaystyle{b_i = \sum_{s, t} w_{s,t}^{i} = \sum_{s, t} \frac{n_{s,t}^{i}}{n_{s,t}}}$

We identified the plant virome of each sweetpotato sample, and all infected plants were analyzed it as a bipartite networks; one set of nodes indicating the host and another subset of nodes indicating the virus - the virus species complex - where a disconnected graph represents a mixed infection, otherwise a single infection.

-----

The Sub-Saharan Africa sweetpotato crop area was retrieved from two databases: Monfreda et al., available at [earthstat](http://www.earthstat.org/) and [MapSpam](https://www.mapspam.info/data/).\
[Seven regions](https://github.com/ricardoi/sweetpotato_virome/blob/main/results/00-Aswp_kcluster-1gamma-2_deg_1e-06_gap_statsMC1000Sep24.pdf) of sweetpotato were determined using a gravity model of a negative exponential distribution using the mean harvested area with a resolution of 1 degree (described in full in [Xing et al. 2020](https://academic.oup.com/bioscience/article/70/9/744/5875255)).

Seven sweetpoato regions results:\
Region 1- [k-cluster 1](https://github.com/ricardoi/sweetpotato_virome/tree/main/results/k-cluster1): Tanzania and Uganda\
Region 2- [k-cluster 2](https://github.com/ricardoi/sweetpotato_virome/tree/main/results/k-cluster2): Guinea\
Region 3- [k-cluster 3](https://github.com/ricardoi/sweetpotato_virome/tree/main/results/k-cluster3): Benin, Ghana and Nigeria\
Region 4- [k-cluster 4](https://github.com/ricardoi/sweetpotato_virome/tree/main/results/k-cluster4): Malawi, Mozambique, Tanzania and Zimbabwe\
Region 5- [k-cluster 5](https://github.com/ricardoi/sweetpotato_virome/tree/main/results/k-cluster5): Mozambique and Zimbabwe\
Region 6- [k-cluster 6](https://github.com/ricardoi/sweetpotato_virome/tree/main/results/k-cluster6): Ethiopia\
Region 7- [k-cluster 7](https://github.com/ricardoi/sweetpotato_virome/tree/main/results/k-cluster7): Angola\

<center>
# ![7k-cluster](https://github.com/ricardoi/sweetpotato_virome/blob/main/images/SSA-SPV-kcluster-1gamma-2_deg_1e-06_gap_statsMC1000.png){
width=20% }
</center>

