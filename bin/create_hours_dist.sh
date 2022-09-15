#!/bin/bash

# Make a temporary file for storing usernames
Hour_file=$(mktemp)

# Take the directory that we will be working out of as the only argument
client_dir=$1

# Go into the directory that has been taken as an argument
cd "$client_dir" || exit

## Concatenate the files containing all failed log-in attempts
cat ./*/failed_login_data.txt 
