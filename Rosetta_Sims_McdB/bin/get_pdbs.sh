#!/bin/bash
#
##
##get_pdbs.sh script retrives all the pdbs from the silent files in a specified directory
##
# variables 1 = scratch file name "relax_kcnq3_AO_10_1_2020" 2= mode
set -euo pipefail 
PATH_TO_FILE=${1}
PATH_TO_ROSETTA=/home/limcaoco/rosetta/rosetta3.12

${PATH_TO_ROSETTA}/main/source/bin/extract_pdbs.default.linuxgccrelease \
       -in:file:silent ${PATH_TO_FILE} \
       -out:pdb_gz \
       -in:file:tagfile tagfiles/##tagfilename
