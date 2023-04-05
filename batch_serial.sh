#!/bin/bash
## (c) m.bane@mmu.ac.uk
##
## script to run $1 (within current "work" directory) as serial
##
## batch system flags:
#SBATCH -p standard --qos=short --account=ta094-mmuteach
# max wallclock time (minutes)
#SBATCH -t 2
# 1 core on 1 node
#SBATCH -n 1 -N 1

## trap any errors and quit immediately
trap 'echo error occurred on line $LINENO;exit -1' ERR

if [[ $# -ne 1 ]] ; then
echo Error\: you need to provide name of serial executable\!
echo Usage\: $0 exeFile
echo \- Runs \$exeFile serially
exit -1
fi

# use this if wish to debug by seeing what is being executed
# set -x
EXE=$1
ls -l $EXE        # quick check as to what we about to run

echo Running $EXE in directory $PWD
./${EXE}