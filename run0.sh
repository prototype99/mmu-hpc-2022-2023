#!/bin/bash
for FLAG in 0 1 2 3 fast
do
sbatch batch_mpi_scaling-n1.sh ASSESS-barrier-O${FLAG}.exe
done
for FLAG in 0 1 2 3 fast
do
sbatch batch_mpi_scaling-n2.sh ASSESS-barrier-O${FLAG}.exe
done