#!/bin/bash

ATPASE_ID='McdA_4'
PEPTIDE_ID='MTDAF'
DATE='5_10_2022'
SCRATCH_DIR=/scratch/ave_root/ave0/limcaoco/ddG_${ATPASE_ID}_other_${DATE}
MUTATION_FILE='McdA_mut_list.txt'
MUTATIONS=$(cat ${MUTATION_FILE})

mkdir ${SCRATCH_DIR}

while read MUTATION; do
    echo 'ddG_wrap.sh: creating NATAA files for: ' ${ATPASE_ID}
    #echo ${MUTATION}
    #making mutation res file
    MUTATION_RES=${MUTATION:0:3}
    cd /home/limcaoco/ATPase_project/input_files/mut_resfiles/
    echo 'NATAA' > ${ATPASE_ID}_${MUTATION_RES}_mut.txt
    echo 'start' >> ${ATPASE_ID}_${MUTATION_RES}_mut.txt
    echo ${MUTATION} >> ${ATPASE_ID}_${MUTATION_RES}_mut.txt
    MUT_FILE_NAME=${ATPASE_ID}_${MUTATION_RES}_mut.txt
    cd /home/limcaoco/ATPase_project/bin

    echo 'ddG_wrap.sh: starting flexDDG.sh'
    #calling flexDDG.sh
    mkdir ${SCRATCH_DIR}/${MUTATION_RES}
    sbatch FlexDDG.sh ${ATPASE_ID} ${PEPTIDE_ID} ${MUTATION_RES} ${MUT_FILE_NAME} ${DATE}
done <${MUTATION_FILE} 



