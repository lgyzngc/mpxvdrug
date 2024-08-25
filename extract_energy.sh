#!/bin/bash

# Author: Bruce Zhou
# Date: 2024-04-03

# Create an empty array to store the lowest affinities and file names
lowest_affinities=()
file_names=()

# Iterate over all log files in the current directory
for log_file in ./bioactiveResults/EBC*.log; do
    # Use awk to extract the lowest affinity from the log file
    lowest_affinity=$(awk '/^ *[0-9]+ +(-?[0-9]+\.[0-9]+) +[0-9]+ +[0-9]+$/ {if (NR == 1 || $2 < lowest) lowest = $2} END {print lowest}' "$log_file")
    
    # Check if lowest_affinity is not empty
    if [[ -n "$lowest_affinity" ]]; then
        # Add the lowest affinity to the array
        lowest_affinities+=("$lowest_affinity")
        
	# Create base name
	baseName=$(basename $log_file)

        # Add the file name to the array
        file_names+=("${baseName%.log}")
    fi
done

# Combine file names and lowest affinities into a single array
combined_data=()
for ((i=0; i<${#file_names[@]}; i++)); do
    combined_data+=("${file_names[i]}\t${lowest_affinities[i]}")
done

# Sort the combined data in ascending order based on the second column (lowest affinities)
sorted_data=($(printf "%s\n" "${combined_data[@]}" | sort -k2,2 -g))

# Print the sorted data with two columns, separated by a tab
for data in "${sorted_data[@]}"; do
    echo -e "$data"
done
