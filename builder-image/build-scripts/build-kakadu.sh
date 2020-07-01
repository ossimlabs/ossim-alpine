#!/bin/bash
cd ossim-private/kakadu/v7_7_1-01123C

for x in $(grep -l pthread_yield\(\)  $(find . -type f)); do 
    sed -i 's/pthread_yield();/sched_yield();/g' $x
done

cd make
make -f Makefile-Linux-x86-64-gcc
#rm $(find . -name "*.so")
