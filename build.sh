#!/bin/bash
#could this be simplified? probably, but let's just play it safe
FLAG=0
cc ASSESS-barrier.c -O${FLAG} -o ASSESS-barrier-O${FLAG}.exe
mv ASSESS-barrier-O${FLAG}.exe $WORK/a
FLAG=1
cc ASSESS-barrier.c -O${FLAG} -o ASSESS-barrier-O${FLAG}.exe
mv ASSESS-barrier-O${FLAG}.exe $WORK/a
FLAG=2
cc ASSESS-barrier.c -O${FLAG} -o ASSESS-barrier-O${FLAG}.exe
mv ASSESS-barrier-O${FLAG}.exe $WORK/a
FLAG=3
cc ASSESS-barrier.c -O${FLAG} -o ASSESS-barrier-O${FLAG}.exe
mv ASSESS-barrier-O${FLAG}.exe $WORK/a
FLAG=fast
cc ASSESS-barrier.c -O${FLAG} -o ASSESS-barrier-O${FLAG}.exe
mv ASSESS-barrier-O${FLAG}.exe $WORK/a