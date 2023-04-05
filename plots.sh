#!/bin/bash

if [[ "$#" -ne 1 ]]; then
echo use $0 FILE where FILE is the input data file
exit
else
echo using $1 col 1 as \#cores and col 2 as time
fi
echo if you get an error that command gnuplot is not found then run \"module load gnuplot\"

t1=`head -1 $1|awk '{print $2}'`;echo t1 $t1
gnuplot -persist <<EOF
plot '$1' w lp t 'performance: time'
EOF

gnuplot -persist <<EOF
set logscale xy
plot '$1' w lp t 'log-log time'
EOF

gnuplot -persist <<EOF
plot [1:130][1:130] '$1' u 1:($t1/\$2) w lp t 'speed-up, Sp'
EOF

gnuplot -persist <<EOF
#plot [][0:] '$1' u 1:(100*$t1/\$2/\$1) w lp t 'efficiency, Ep'
plot [][:110] '$1' u 1:(100*$t1/\$2/\$1) w lp t 'efficiency, Ep'
EOF