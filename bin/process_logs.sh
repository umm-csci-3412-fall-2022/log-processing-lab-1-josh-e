#!/bin/bash

# Create temporary directory for processing computer logs
Failed_Passwords_dir=$(mktemp -d)

#For each argument (computer data):
## Take the name of the computer
## Make a directory in the temporary directory with the computer name as the name of the dirrectory
## un-gzip the arguments and place them into their respective computer directories
## Process the client logs in their computer directories
for arg in "$@"
	do 
		Computer_dir=$(echo $arg | awk 'match($0, /\/([^.]+)\.tgz/, groups) {print groups[1] }' )
		mkdir "$Failed_Passwords_dir"/"$Computer_dir"
		tar -xzf $arg -C "$Failed_Passwords_dir"/"$Computer_dir"

		./bin/process_client_logs.sh "$Failed_Passwords_dir"/"$Computer_dir"
	done

