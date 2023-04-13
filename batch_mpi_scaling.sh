#!/bin/bash
## (c) m.bane@mmu.ac.uk
##
## script to run $1 (within current "work" directory) as MPI
## sbatch can set:
##   "-N #nodes"     (saved as $SLURM_NNODES, for example)
##   "-n #processes" (saved as $SLURM_NTASKS_PER_NODE)
##
## batch system flags:
#SBATCH -p standard --qos=short --account=ta094-mmuteach
# max wallclock time (minutes)
#SBATCH -t 2
# number of cores & nodes
#   -- set a default of 1 node on which we run up to 128 processes
#SBATCH -N 1 -n 128

## further info on sbatch options for ARCHER2: https://docs.archer2.ac.uk/user-guide/scheduler

## trap any errors and quit immediately
trap 'echo error occurred on line $LINENO;exit -1' ERR

if [[ $# -ne 1 ]] ; then
echo Error\: you need to provide name of OpenMP executable\!
echo Usage\: $0 exeFile
echo \- Runs \$exeFile on 1 up to number of cores avail to job
echo NB view $0 for actual values of \#threads used
exit -1
fi

# use this if wish to debug by seeing what is being executed
# set -x

EXE=$1
ls -l $EXE        # quick check as to what we about to run

# create unique (using jobID) file to save #threads & time taken
TIMING=mpi_time-${SLURM_JOBID}.txt
touch $TIMING
echo saving timing into to $TIMING

# define number of MPI processes "--ntasks=${ranks}"
# bind MPI process to physical processor core in order of rank & core number "--cpu-bind=rank"
# can use "--cpu-bind=verbose"

export OMP_NUM_THREADS=1 # good practise to prevent any threaded system libraries spawning new threads

TMPFILE=/tmp/${USER}-mpi.txt

# loop over various number of MPI processes, copying timing output to $TIMING
for NODES in 1 2 3 4
do
for PROCS in 8 16 24 32 40 48 56 64 72 80 88 96 104 112 120 128
do
echo Running $EXE in directory $PWD on $PROCS MPI processes
srun --nodes=${NODES} --ntasks=${PROCS} --cpu-bind=verbose,rank ./${EXE} | tee ${TMPFILE}
time=`grep seconds ${TMPFILE} |awk '{print $(NF-1)}'`
echo $PROCS $time >> $TIMING
done
done

cat $TIMING
# use gnuplot to plot contents of $TIMING
# explain your findings
