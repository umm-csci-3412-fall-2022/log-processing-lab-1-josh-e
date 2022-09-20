#!/bin/bash

# Create a temporary file for storing the reports
Reports=$(mktemp)

# Take the directory that we will be working out of as the only argument
report_dir=$1

# Go into the directory taken as the only argument
cd "$report_dir" || exit

cat ./country_dist.html hours_dist.html username_dist.html > "$Reports"
