#!/bin/bash

# Create a temporary file for storing the reports
Reports=$(mktemp)

# Take the directory that we will be working out of as the only argument
report_dir=$1

# Go into the directory taken as the only argument
cd "$report_dir" || exit

# Concatenate the distribution data files in the argument directory
# and put that into the reports temp file
cat country_dist.html hours_dist.html username_dist.html > "$Reports"

# Use wrap contents, with the temporary file as the text input and summary plots
# headers/footers, into one collected .html
../bin/wrap_contents.sh "$Reports" ../html_components/summary_plots failed_login_summary.html
