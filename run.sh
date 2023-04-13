#!/bin/bash
for NODE in 1 2 3 4
do
for FLAG in 0 1 2 3 fast
do
sbatch batch_mpi_scaling-n${NODE}.sh ASSESS-barrier-O${FLAG}.exe
done
done