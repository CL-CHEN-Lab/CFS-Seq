# CFS-Seq  
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

Analysis of Repli-Seq data under replication stress to map common fragile sites (CFSs) :   
From count matrices to SDR (significantly delayed region) identification and characterization.

## Description :
 
This repository aims at demonstrating the computational analysis that lead to some results exposed in the paper :  
[*Transcription-mediated organization of the replication initiation program across large genes promotes common fragile sites genome-wide*]( https://doi.org/10.1101/714717 ).  
 
We provide here the methods for analyzing Repli-seq data, such as our publically available **--ADD Geo link here--** under normal versus replication stress conditions, aiming at identifying and characterizing SDR (significantly delayed regions) which we showed to be correlated with molecular mapping of common fragile in human lymphocytes.  

This repository features R scripts as well as bashscripts.  
The detailed analysis methods are presented in reports/ and raw source code can be found in src/  

## Dependencies :

This methods make use of  R (>=3.4.4) packages :  
* RepliSeq (only available on github [here](https://github.com/CL-CHEN-Lab/RepliSeq))
* dplyr (>= 0.8.3) 
* magrittr (>= 1.5)

We also made use of :  
* bedtools (>= v2.25.0)

## Authors : 

Sami EL HILALI : sami.el-hilali@curie.fr  

Chunlong CHEN : chunlong.chen@curie.fr

Don't hesitate to contact the authors or open an issue for any question.

 
 
