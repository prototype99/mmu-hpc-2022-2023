#!/bin/bash
for FLAG in 0 1 2 3 fast
do
sbatch batch_mpi_scaling.sh ASSESS-barrier-O${FLAG}.exe
done