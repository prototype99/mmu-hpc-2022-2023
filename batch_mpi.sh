#!/bin/bash
## (c) m.bane@mmu.ac.uk
##
## script to run $1 (within current "work" directory) as MPI
## sbatch can set:
##   "-N #nodes"     (saved as $SLURM_NNODES, for example)
##   "-n #processes" (saved as $SLURM_NPROCS)
##
## batch system flags:
#SBATCH -p standard --qos=short --account=ta094-mmuteach
# max wallclock time (minutes)
#SBATCH -t 2
# number of cores & nodes
#   -- set a default of 1 (change '-n' parameter to control total number of #MPI processes)
#SBATCH -N 1 -n 1

## further info on sbatch options for ARCHER2: https://docs.archer2.ac.uk/user-guide/scheduler

## trap any errors and quit immediately
trap 'echo error occurred on line $LINENO;exit -1' ERR

if [[ $# -ne 1 ]] ; then
echo Error\: you need to provide name of OpenMP executable\!
echo Usage\: $0 exeFile
echo \- Runs \$exeFile on number of processes defined by '-n' arg to sbatch
exit -1
fi

# use this if wish to debug by seeing what is being executed
# set -x

## determine from SLURM env vars how many MPI processes to run, one per core
## note that we can control this in a fine-grained manner should we wish
## but here we merely invoke 'srun' which usually knows best
echo SLURM job has ${SLURM_NPROCS} processes over $SLURM_NNODES nodes

EXE=$1
ls -l $EXE        # quick check as to what we about to run

echo Running $EXE in directory $PWD via srun on $SLURM_NPROCS MPI processes over $SLURM_NNODES nodes
export OMP_NUM_THREADS=1 # good practise to prevent any threaded system libraries spawning new threads
srun ./${EXE}
