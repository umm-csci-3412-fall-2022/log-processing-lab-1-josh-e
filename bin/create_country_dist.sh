#!/bin/bash

# Make two temporary files for storing country origin
Country_file=$(mktemp)
IP_file=$(mktemp)

# Take the directory that we will be working out of as the only argument
computers_file=$1

# Go into the directory that has been taken as an argument
cd "$computers_dir" || exit

## Concatenate the files containing failed log-in attempts from all computers
## Extract the IP address data in the fifth column
## Sort the IP address data so that the join function works
cat ./*/failed_login_data.txt | awk '{print $5}' | sort > $IP_file 
