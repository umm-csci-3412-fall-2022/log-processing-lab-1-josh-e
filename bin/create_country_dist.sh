#!/bin/bash

# Make a temporary file for storing country origin
Country_file=$(mktemp)

# Take the directory that we will be working out of as the only argument
computers_file=$1

# Go into the directory that has been taken as an argument
cd "$computers_dir" || exit

## Concatenate the files containing failed log-in attempts from all computers
## Extract the country of origin data in the fifth column
cat ./*/failed_login_data.txt | awk '{print $5}' 
