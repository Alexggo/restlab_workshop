#!/usr/bin/env bash


# Create variable that we will use later
WatchMe=$(echo whip nae nae)

# This is where I whip
echo Now watch me "$(echo $WatchMe | cut -d " " -f 1)"

# This is where I nae nae
echo Now watch me "$(echo $WatchMe | cut -d " " -f 2,3)"


