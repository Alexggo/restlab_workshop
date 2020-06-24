#!/usr/bin/env bash

# GNU parallel example

module load gnu-parallel/6.0

ls *.txt | parallel -j 10 --verbose "sed -i 's/very/not/g' {}" 
