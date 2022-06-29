#!/bin/bash
#
#
#SBATCH --job-name=MTDAF_abinitio
#SBATCH --account=ave0
#SBATCH --partition=standard
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=5000m
#SBATCH --time=00-4:00:00
#SBATCH --array=1
#SBATCH --output=FastRelax.log
#SBATCH --mail-user=limcaoco@med.umich.edu
#SBATCH --mail-type=END,FAIL
set -euo pipefail
module load gcc/4.8.5
JOB_ID=$SLURM_JOB_ID
TASK_ID=$SLURM_ARRAY_TASK_ID
PATH_TO_ROSETTA=/home/limcaoco/rosetta/rosetta3.12
PATH_TO_PROJ=/home/limcaoco/ATPase_project
ATPASE_ID='MTDAF'
DATE='02_24_2022'
SCRATCH_DIR=/scratch/ave_root/ave0/limcaoco/disorder_${ATPASE_ID}_${DATE}
#run relax; be sure to change the -in:file:silent directory and options directory
${PATH_TO_ROSETTA}/main/source/bin/ResidueDisorder.default.linuxgccrelease \
    -in:file:l abinit_joe_list \
    -corrections::restore_talaris_behavior true \
    #-out:file:o ${SCRATCH_DIR}/out_files/${ATPASE_ID}_disorder_${JOB_ID}_${TASK_ID}.out \
    > ${SCRATCH_DIR}/${ATPASE_ID}_disorder_${JOB_ID}_${TASK_ID}.log
##
## creating .err file from STDERR
##
command 2> ${SCRATCH_DIR}/relax_${JOB_ID}.err
command 1> ${SCRATCH_DIR}/relax_${JOB_ID}.txt
