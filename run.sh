#!/bin/bash

C_RESULTS=c_res.csv
PY_RESULTS=py_res.csv

FILE_HEADER="iterations,cpu used,cpu time (s),real time (s)"

function remove_file {
    local filename=$1
    if [ -e $filename ]; then
        rm $filename
    fi
}

function init_files {
    remove_file $C_RESULTS
    remove_file $PY_RESULTS
    echo $FILE_HEADER >> $C_RESULTS
    echo $FILE_HEADER >> $PY_RESULTS
}

function run {
    for (( i=1; i<=10000000; i=$i*10 ))
    do
        run_iteration $i
    done
}

function run_iteration {
    local loop_count=$1
    local time_args="-f $loop_count,%P,%S,%E"
    { /usr/bin/time $time_args bin/append $loop_count ; } 2>> $C_RESULTS
    { /usr/bin/time $time_args python3 append.py $loop_count ; } 2>> $PY_RESULTS
}

init_files
run
exit 0
