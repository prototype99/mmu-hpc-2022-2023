#!/bin/bash
## (c) m.bane@mmu.ac.uk | alterations by 19096347@stu.mmu.ac.uk
## batch system flags:
#SBATCH -p standard --qos=short --account=ta094-mmuteach
#SBATCH -N 3

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
for PROCS in 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384
do
echo Running $EXE in directory $PWD on $PROCS MPI processes
srun --nodes=3 --ntasks=${PROCS} --cpu-bind=verbose,rank ./${EXE} | tee ${TMPFILE}
time=`grep seconds ${TMPFILE} |awk '{print $(NF-1)}'`
echo $PROCS $time >> $TIMING
done

cat $TIMING