#!/bin/bash
#
#
#SBATCH --job-name=energy_cluster
#SBATCH --account=ave0
#SBATCH --partition=standard
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=02-12:00:00
#SBATCH --array=1
#SBATCH --output=energy_cluster.log
#SBATCH --mail-user=limcaoco@med.umich.edu
#SBATCH --mail-type=END,FAIL
set -euo pipefail
module load gcc/4.8.5
JOB_ID=$SLURM_JOB_ID
TASK_ID=$SLURM_ARRAY_TASK_ID
PATH_TO_ROSETTA=/home/limcaoco/rosetta/rosetta3.12
SCRATCH_DIR=/scratch/ave_root/ave0/limcaoco
ATPASE_ID='McdA'
PEPTIDE_ID='MTDAF'
DATE='01_12_2022'
PROJECT_PATH=/home/limcaoco/ATPase_project
#run relax; be sure to change the -in:file:silent directory and options directory
${PATH_TO_ROSETTA}/main/source/bin/energy_based_clustering.default.linuxgccrelease \
    -in:file:l ${SCRATCH_DIR}/flex_dock_${PEPTIDE_ID}_${ATPASE_ID}_${DATE}/pdbs/top_1000_list\
    -cluster:energy_based_clustering:silent_output  \
    -cluster:energy_based_clustering:cluster_radius 3.0 \
    -cluster:energy_based_clustering:cluster_by bb_cartesian \
    > ${PROJECT_PATH}/output_files/clustering/${ATPASE_ID}_clustering_${JOB_ID}_${TASK_ID}.log
##
## creating .err file from STDERR
##
command 2> ${SCRATCH_DIR}/relax_${JOB_ID}.err
command 1> ${SCRATCH_DIR}/relax_${JOB_ID}.txt
