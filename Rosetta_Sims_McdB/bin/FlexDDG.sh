#!/bin/bash
#
#
#SBATCH --job-name=carboxysome_flex_ddG
#SBATCH --account=ave0
#SBATCH --partition=standard
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00-03:00:00
#SBATCH --array=1-35
#SBATCH --output=DDG.log
#SBATCH --mail-user=limcaoco@med.umich.edu
#SBATCH --mail-type=END,FAIL
set -euo pipefail
module load gcc/4.8.5
JOB_ID=$SLURM_JOB_ID
TASK_ID=$SLURM_ARRAY_TASK_ID
PATH_TO_ROSETTA=/home/limcaoco/rosetta/rosetta3.12
PATH_TO_PROJ=/home/limcaoco/ATPase_project
ATPASE_ID=${1}
PEPTIDE_ID=${2}
DATE=${5}
MUTATION=${3}
MUT_FILE_NAME=${4}
SCRATCH_DIR=/scratch/ave_root/ave0/limcaoco/ddG_${ATPASE_ID}_other_${DATE}


mkdir ${SCRATCH_DIR}/${MUTATION}/${TASK_ID}
#cd ${SCRATCH_DIR}/${MUTATION}/${TASK_ID}
#run relax; be sure to change the -in:file:silent directory and options directory
${PATH_TO_ROSETTA}/main/source/bin/rosetta_scripts.default.linuxgccrelease \
    -database ${PATH_TO_ROSETTA}/main/database \
    @ ${PATH_TO_PROJ}/input_files/options/generic_ddG.options \
    -in:file:s ${PATH_TO_PROJ}/intermediate_files/docked_receptors/${PEPTIDE_ID}_pep_${ATPASE_ID}.pdb \
    -parser:script_vars filename=/home/limcaoco/ATPase_project/input_files/mut_resfiles/${MUT_FILE_NAME} \
    -run:jran ${JOB_ID} \
    -out:suffix _${TASK_ID}_${JOB_ID} \
    -out:path:all ${SCRATCH_DIR}/${MUTATION}/${TASK_ID} \
    -out:nstruct 1 \
    -out:file:silent ${SCRATCH_DIR}/${MUTATION}/${TASK_ID}/${ATPASE_ID}_ddG_${JOB_ID}_${TASK_ID}.out \
    > ${SCRATCH_DIR}/${MUTATION}/${TASK_ID}/rosetta.out
##
## creating .err file from STDERR
##
#command 2> ${SCRATCH_DIR}/ddG_${JOB_ID}.err
#command 1> ${SCRATCH_DIR}/ddG_${JOB_ID}.txt
