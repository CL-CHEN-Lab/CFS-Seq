
# This file is part of CFS-Seq.
# 
# CFS-Seq is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation version 3.
# 
# CFS-Seq is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with CFS-Seq.  If not, see <https://www.gnu.org/licenses/>.

## ---------------------------
##
## Script : Generate_SDW_SDR.sh
##
## Author: Sami EL HILALI
##
## Date Created: 2019-11-08
##
## ---------------------------

## DO

# 1 - extract SDW as windows with (20 > MeanXY > 40) && (URI <= -2) :
awk '(($6 >20) && ($6 < 40) && ($7 <= -2)) {print $1"\t"$2"\t"$3"\t"$7}' ../inst/outputs/URI_Aph1_NT1_50kb.tab > ../inst/outputs/SDW.bed

# 2 - merge adjacent SDW into SDR and those at max 250kb distance from SDR :
bedtools merge -i ../inst/outputs/SDW.bed |
awk '{if (($3 - $2) > 50000) { print $1"\t"$2"\t"$3}}' |
bedtools merge -i - -d 250000 |
bedtools sort -i - > ../inst/outputs/temp.SDR.bed

# 3 - write SDW with removing those clustering in SDR :
bedtools merge -i ../inst/outputs/SDW.bed |
awk '{if (($3 - $2) == 50000) { print $1"\t"$2"\t"$3}}' |
bedtools sort -i - > ../inst/outputs/temp.SDW_minus_SDR.bed

# 4 - merge again SDW at max 250kb distance to SDR with corresponding SDR :
bedtools closest -a ../inst/outputs/temp.SDR.bed -D "b" -b ../inst/outputs/temp.SDW_minus_SDR.bed |
awk '{ if(($7 <= 250000) && ($7 >= -250000)) {print}}' |
awk '{ if ($7 > 0) { print $1"\t"$2"\t"$6} else {print $1"\t"$5"\t"$3}}' |
bedtools sort -i - > ../inst/outputs/temp.SDR_plus_closest_SDW.bed

cat ../inst/outputs/temp.SDR.bed ../inst/outputs/temp.SDR_plus_closest_SDW.bed |
bedtools sort -i - |
bedtools merge -i - > ../inst/outputs/SDR.bed

# 5 - rewrite SDW with removing those clustering in SDR :

bedtools closest -a ../inst/outputs/temp.SDR.bed -D "b" -b ../inst/outputs/temp.SDW_minus_SDR.bed |
awk '{ if(($7 <= 250000) && ($7 >= -250000)) { print $4"\t"$5"\t"$6}}' |
bedtools subtract -a ../inst/outputs/temp.SDW_minus_SDR.bed -b - -A > ../inst/outputs/SDW_clean.bed

## remove temp files :
rm ../inst/outputs/temp.*

## DONE
