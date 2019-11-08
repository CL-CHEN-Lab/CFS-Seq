# CFS-Seq  
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

Analysis of Repli-Seq data under replication stress to map common fragile sites (CFSs) :   
From count matrices to SDR (significantly delayed region) identification.

## Introduction :
 
This repository aims at demonstrating the computational analysis that lead to some results exposed in the paper :  
[*Transcription-mediated organization of the replication initiation program across large genes promotes common fragile sites genome-wide*]( https://doi.org/10.1101/714717 ).  
 
We provide here the methods for analyzing Repli-seq data, such as our publically available **--ADD Geo link here--** normal growth conditions versus replication stress conditions, aiming at identifying and characterizing SDR (significantly delayed regions) which we showed to be correlated with molecular mapping of common fragile sites (CFS) in human lymphocytes.  

This repository contains R scripts and bash scripts.  
The detailed analysis methods are presented in the following sections and executable source code can be found in src/  

## Dependencies :

This methods make use of  R (>=3.4.4) packages :  
* RepliSeq (available on github [here](https://github.com/CL-CHEN-Lab/RepliSeq))
* dplyr (>= 0.8.3) 
* magrittr (>= 1.5)

We also made use of :  
* bedtools (>= v2.25.0)
* wigToBigWig (>= v4)

## Calculate Under Replication Index (URI) :

As a first step we propose to measure the effect of DNA replicated under stress condition (Aph) simulated with Aphidicolin, an inhibitor of DNA polymerase II compared to normal growth conditions (NT). The following replication profiles at FHIT and WWOX, two major CFS, show how URI translate the difference between the normal profile (NT) displayed in grey and the replication stress condition (Aph) displayed in black.

<p align="center">
<img src="inst/img/FHIT_WWOX_replication_profiles.png" width="400" height="400">
 </p>
 
 We defined URI as the Z-score of the difference between the sum of reads per genomic window (50kb here) in cells treated with Aph (Aph) or not (NT) (=> Delta(Aph-NT)) and it's calculation is implemented in the [RepliSeq package](https://github.com/CL-CHEN-Lab/RepliSeq).  
The results presented in the paper (Brison et al.) were obtained by calculating URI based on the comparison of 50kb adjacent windows profiles for which the sum of each fraction (S1-6) was normalized to 15M (data in [inst/extdata](https://github.com/CL-CHEN-Lab/CFS-Seq/tree/master/inst/extdata)).  

The R script for generating [URI_Aph1_NT1_50kb.[tab/bed/wig/bw]](https://github.com/CL-CHEN-Lab/CFS-Seq/tree/master/inst/outputs) is at [src/GenerateURI.R](https://github.com/CL-CHEN-Lab/CFS-Seq/tree/master/src/GenerateURI.R))
 

## Generate Significantly Delayed Windows (SDW) and Regions (SDR) :

We then defined significantly delayed windows (SDW) as 50kb windows having an significanly low under replication index (URI <= -2). We found that these SDW were clustering together so we extended it as regions (SDR). The red boxes on the profiles below show the identified SDR for FHIT (FRA3B) and WWOX (FRA16D) genes.


<p align="center">
<img src="inst/img/FHIT_WWOX_replication_profiles_SDR.png" width="400" height="400">
 </p>

We defined SDW as the windows with 20 < mean(Aph,NT) < 40 and URI <= -2.
The results presented in the paper (Brison et al.) were obtained by proceeding as follow :

* extract all SDW -> SDW.bed
* merge adjacent SDW into SDR and those at max 250kb distance from SDR 
* merge again SDR with closest SDW (max 250kb distance) (-> SDR.bed)
* retrieve the SDW not clustering into SDR (SDW_clean.bed)

The shell script for generating [SDW.bed/SDW_clean.bed/SDR.bed](https://github.com/CL-CHEN-Lab/CFS-Seq/tree/master/inst/outputs) is at [src/Generate_SDW_SDR.sh](https://github.com/CL-CHEN-Lab/CFS-Seq/tree/master/src/Generate_SDW_SDR.sh))
 

## Authors : 

Sami EL HILALI : sami.el-hilali@curie.fr  

Chunlong CHEN : chunlong.chen@curie.fr

Don't hesitate to contact the authors or open an issue for any question.

