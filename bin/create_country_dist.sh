#!/bin/bash

# Make a temporary file for storing country origin
Country_file=$(mktemp)

# Take the directory that we will be working out of as the only argument
Client_file=$1

# Go into the directory that has been taken as an argument
cd "$client_dir" || exit
