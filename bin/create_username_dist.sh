#!/bin/bash

# Take the directory that we will be working out of as the only argument
client_dir=$1 

# Go into the directory that has been taken as an argument
cd '$client_dir' || exit

cat */*/failed_login_data.txt
