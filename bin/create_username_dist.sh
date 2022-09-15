#!/bin/bash

# Take the directory that we will be working out of as the only argument
client_dir=$1 

# Go into the directory that has been taken as an argument
cd $client_dir

## Concatenate the files containing all failed log-in attempts
## Extract the username data in the fourth column 
## Sort the usernames so that the uniq command works
cat ./*/failed_login_data.txt | awk '{print $4}' | sort
