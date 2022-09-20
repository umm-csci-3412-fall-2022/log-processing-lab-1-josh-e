#!/bin/bash

# Create temporary directory for processing computer logs
Failed_Passwords_dir=$(mktemp -d)

#For each argument (computer data):
## Make a directory in the temporary directory with the computer name as the name of the dirrectory
## un-gzip the arguments and place them into their respective computer directories
## Process the client logs in their computer directories
for cptr in "$@"
	do 
		## Take the name of the computer
		Cptr_dir=$(echo "$cptr" | awk 'match($0, /\/([^.]+)\.tgz/, groups) {print groups[1] }' )
		
		## Make a directory in the temporary directory with the computer name as the name of the dirrectory
		mkdir "$Failed_Passwords_dir"/"$Cptr_dir"
		
		## un-gzip the arguments and place them into their respective computer directories
		tar -xzf "$cptr" -C "$Failed_Passwords_dir"/"$Cptr_dir"
		
		## Process the client logs in their computer directories
		./bin/process_client_logs.sh "$Failed_Passwords_dir"/"$Cptr_dir"
	done

# Create a .html chart for username, hours, ad country distribution of 
# failed password attempts
./bin/create_username_dist.sh "$Failed_Passwords_dir"
./bin/create_hours_dist.sh "$Failed_Passwords_dir"
./bin/create_country_dist.sh "$Failed_Passwords_dir"

# Wrap the charts for username, hours, and country distribution of
# failed password attempts into one .html file
./bin/assemble_report.sh "$Failed_Passwords_dir"

# Move the failed login summary out of the temporary directory
mv "$Failed_Passwords_dir"/failed_login_summary.html .

# Remove the temporary directory
rm -rf "$Failed_Passwords_dir"

