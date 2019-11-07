
# This file is part of CFS-seq.
# 
# CFS-seq is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation version 3.
# 
# CFS-seq is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with Foobar.  If not, see <https://www.gnu.org/licenses/>.

## ---------------------------
##
## Script : GenerateURI.R
##
## Author: Sami EL HILALI
##
## Date Created: 2019-11-07
##
## ---------------------------

## DO

# Imports :
library(dplyr)
library(RepliSeq)

# Data input :
rs_fractions <- paste0("S",c(1:6))
NT_paths <- paste0("../inst/extdata/NT1-",rs_fractions,".bdg")
Aph_paths <- paste0("../inst/extdata/Aph1-",rs_fractions,".bdg")

# load Repli-seq :
NT_50kb <- RepliSeq::readRS(NT_paths,rs_fractions)
head(NT_50kb,2)
Aph_50kb <- RepliSeq::readRS(Aph_paths,rs_fractions)
head(Aph_50kb,2)

# calculate URI :
URI_Aph_NT <- RepliSeq::calculateURI(Aph_50kb,NT_50kb)
head(URI_Aph_NT,2)

# write BED :
to_write <- URI_Aph_NT %>% select(chr,start,stop,URI)
head(to_write,2)
write.table(to_write,
            file = "../inst/outputs/URI_Aph1_NT1_50kb.bed",
            quote = FALSE,
            row.names = FALSE,
            col.names = FALSE,
            sep = "\t")

# write Wiggle :
to_write <- NULL
for ( chr_name in paste0("chr",c(1:22,"X"))) {
  wiggle_header <- paste0("fixedStep chrom=",chr_name," start=1 step=50000 span=50000")
  wiggle_value <- subset(URI_Aph_NT,chr == chr_name)
  wiggle_value[is.na(wiggle_value)] <- 0
  to_write <- c(to_write,wiggle_header,wiggle_value[,"URI"])
  # print(to_write)
}
write.table(to_write,
            file = "../inst/outputs/URI_Aph1_NT1_50kb.wig",
            quote = FALSE,
            row.names = FALSE,
            col.names = FALSE)

# convert to BigWig :
temp_command <- paste0("wigToBigWig -clip ../inst/outputs/URI_Aph1_NT1_50kb.wig ../inst/extdata/Hg19_chromsizes.txt ../inst/outputs/URI_Aph1_NT1_50kb.bw")
system(temp_command)

## DONE

