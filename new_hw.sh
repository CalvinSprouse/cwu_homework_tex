#!/bin/bash

# Set default template folder path
template_folder="templates/homework"

# Assign positional arguments
folder="$1"
name="$2"

# Check if required arguments are provided
if [[ -z $folder || -z $name ]]; then
    echo "Usage: $0 FOLDER NAME"
    exit 1
fi

# Run the Python script
python3 copy_template.py "$template_folder" "$folder" "$name"
