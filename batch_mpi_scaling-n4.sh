#!/bin/bash
## (c) m.bane@mmu.ac.uk | alterations by 19096347@stu.mmu.ac.uk
## batch system flags:
#SBATCH -p standard --qos=short --account=ta094-mmuteach
#SBATCH -N 4

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
for PROCS in 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 491 492 493 494 495 496 497 498 499 500 501 502 503 504 505 506 507 508 509 510 511 512
do
echo Running $EXE in directory $PWD on $PROCS MPI processes
srun --nodes=4 --ntasks=${PROCS} --cpu-bind=verbose,rank ./${EXE} | tee ${TMPFILE}
time=`grep seconds ${TMPFILE} |awk '{print $(NF-1)}'`
echo $PROCS $time >> $TIMING
done

cat $TIMING