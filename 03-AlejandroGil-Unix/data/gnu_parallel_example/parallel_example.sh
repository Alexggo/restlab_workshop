#!/usr/bin/env bash

# GNU parallel example

module load gnu-parallel/6.0

parallel -j 10 --verbose "sed -i 's/not/very/g' {}" ::: *.txt 
