#!/bin/bash
for FLAG in 0 1 2 3 fast
do
sbatch batch_mpi_scaling-n3.sh ASSESS-barrier-O${FLAG}.exe
done
for FLAG in 0 1 2 3 fast
do
sbatch batch_mpi_scaling-n4.sh ASSESS-barrier-O${FLAG}.exe
done