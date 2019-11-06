# CFS-Seq  
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

Analysis of Repli-Seq data under replication stress to map common fragile sites (CFSs) :   
From count matrices to SDR (significantly delayed region) identification and characterization.

## Introduction :
 
This repository aims at demonstrating the computational analysis that lead to some results exposed in the paper :  
[*Transcription-mediated organization of the replication initiation program across large genes promotes common fragile sites genome-wide*]( https://doi.org/10.1101/714717 ).  
 
We provide here the methods for analyzing Repli-seq data, such as our publically available **--ADD Geo link here--** normal growth conditions versus replication stress conditions, aiming at identifying and characterizing SDR (significantly delayed regions) which we showed to be correlated with molecular mapping of common fragile sites (CFS) in human lymphocytes.  

This repository features R scripts as well as bashscripts.  
The detailed analysis methods are presented in the following sections and executable source code can be found in src/  

## Dependencies :

This methods make use of  R (>=3.4.4) packages :  
* RepliSeq (available on github [here](https://github.com/CL-CHEN-Lab/RepliSeq))
* dplyr (>= 0.8.3) 
* magrittr (>= 1.5)

We also made use of :  
* bedtools (>= v2.25.0)

## Authors : 

Sami EL HILALI : sami.el-hilali@curie.fr  

Chunlong CHEN : chunlong.chen@curie.fr

Don't hesitate to contact the authors or open an issue for any question.

## Calculate Under Replication Index (URI) :

As a first step we propose to measure the effect of DNA replicated under stress condition (Aph) simulated with Aphidicolin, an inhibitor of DNA polymerase II compared to normal growth conditions (NT). 
We defined URI as the Z-score of the difference between the sum of reads per genomic window (50kb here) in cells treated (Aph) or not (NT) with Aph (Delta(Aph-NT))

<p align="center">
<img src="inst/img/FHIT_WWOX_replication_profiles.png" width="400" height="400">
 </p>
 
These replication profiles at FHIT and WWOX, two major CFS, show how URI translate the difference between the normal profile (NT) displayed in grey and the replication stress condition (Aph) displayed in black.


## Generate Significantly Delayed Windows (SDW) and Regions (SDR) :

 
 
