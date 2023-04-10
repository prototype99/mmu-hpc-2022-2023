#!/bin/bash
for FLAG in 0 1 2 3 fast
do
cc ASSESS-barrier.c -O${FLAG} -o ASSESS-barrier-O${FLAG}.exe
mv ASSESS-barrier-O${FLAG}.exe $WORK/a
done