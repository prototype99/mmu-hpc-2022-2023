#!/bin/bash
## (c) m.bane@mmu.ac.uk | alterations by 19096347@stu.mmu.ac.uk
## batch system flags:
#SBATCH -p standard --qos=short --account=ta094-mmuteach

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
for PROCS in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128
do
echo Running $EXE in directory $PWD on $PROCS MPI processes
srun --nodes=3 --ntasks=${PROCS} --cpu-bind=verbose,rank ./${EXE} | tee ${TMPFILE}
time=`grep seconds ${TMPFILE} |awk '{print $(NF-1)}'`
echo $PROCS $time >> $TIMING
done

cat $TIMING