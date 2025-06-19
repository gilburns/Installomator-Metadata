#!/bin/zsh

# Folder containing the Installomator repo
input_dir="${1:-/path/to/your/GitHub/Installomator}"

# Path to the assemble script you want to run
runner_script="${input_dir}/utils/assemble.sh"

# Folder containing the Installomator fragment label files
input_dir="${input_dir}/fragments/labels"

# Create log output folder
mkdir -p "${input_dir}/build_results"

# Loop over each file in the folder
for file_path in "$input_dir"/*; do
    # Skip if not a regular file
    [[ -f "$file_path" ]] || continue

  # Extract filename without extension
    file_name="${file_path:t}"            # Just the filename (e.g., file.txt)
    base_name="${file_name%.*}"           # Remove extension (e.g., file)

  echo "Processing: $base_name"

  # Call your external script with the base name as an argument
    echo "Running $runner_script on $base_name"
    "$runner_script" "$base_name" > "${input_dir}/build_results/$base_name.txt" 2>&1

  # Wait until the script completes (default behavior)
    if [[ $? -ne 0 ]]; then
        echo "Error processing $base_name"
    else
        echo "Finished: $base_name"
    fi
done