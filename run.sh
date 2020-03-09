#!/bin/bash

RESULTS_DIR=results
C_RESULTS=$RESULTS_DIR/c_res.csv
PY_RESULTS=$RESULTS_DIR/py_res.csv
CTYPES_RESULTS=$RESULTS_DIR/ctypes_res.csv

FILE_HEADER="1,10,100,1000,10000,100000,1000000"
TIME_ARGS="-f %S"
MAX_ITER=1000000

function remove_file {
    local filename=$1
    if [ -e $filename ]; then
        rm $filename
    fi
}

function init_files {
    mkdir -p $RESULTS_DIR
    remove_file $C_RESULTS
    remove_file $PY_RESULTS
    remove_file $CTYPES_RESULTS
    echo $FILE_HEADER >> $C_RESULTS
    echo $FILE_HEADER >> $PY_RESULTS
    echo $FILE_HEADER >> $CTYPES_RESULTS
}

function run {
    for (( i=1; i<=100000; i=$i*10 ))
    do
        run_iteration $i
    done
}

function run_iteration {
    local loop_count=$1
    local time_args="-f %S"
    { /usr/bin/time $time_args bin/append $loop_count ; } 2>> $C_RESULTS
    { /usr/bin/time $time_args python3 append.py $loop_count ; } 2>> $PY_RESULTS
    { /usr/bin/time $time_args python3 append_ctypes.py $loop_count ; } 2>> $CTYPES_RESULTS
    exit 0;
}

function run_loop {
    local program=$1
    result=$(eval $program)
    out=$(echo $result | sed -e "s/ //g")
    out=${out::-1}
    echo $out
}

function run_python {
    for (( i=1; i<=$MAX_ITER; i=$i*10 ))
    do
        echo $( { /usr/bin/time $TIME_ARGS python3 append.py $i; } 2>&1)
        echo ","
    done
}

function run_c {
    local program=$1
    for (( i=1; i<=$MAX_ITER; i=$i*10 ))
    do
        echo $( { /usr/bin/time $TIME_ARGS bin/append $i; } 2>&1)
        echo ","
    done
}

function run_hybrid {
    local program=$1
    for (( i=1; i<=$MAX_ITER; i=$i*10 ))
    do
        echo $( { /usr/bin/time $TIME_ARGS python3 append_ctypes.py $i; } 2>&1)
        echo ","
    done
}

echo $(run_loop run_python)
echo $(run_loop run_c)
echo $(run_loop run_hybrid)
exit 0
