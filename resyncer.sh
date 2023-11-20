#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 [path_to_file] [DEST_DIR]"
    exit 1
fi

# Assign arguments to variables for better readability
FILE_TO_SYNC="$1"
DEST_DIR="$2"

# Check if the file exists
if [ ! -f "$FILE_TO_SYNC" ]; then
    echo Error: File "$FILE_TO_SYNC" does not exist.
    exit 1
fi

# Check if the destination directory exists
if [ ! -d "$DEST_DIR" ]; then
    echo "Error: Destination directory "$DEST_DIR" does not exist."
    exit 1
fi

# Perform rsync operation
rsync -av "$FILE_TO_SYNC" "$DEST_DIR"

# Check if rsync was successful
if [ $? -eq 0 ]; then
    echo "File has been successfully rsynced to "$DEST_DIR"."
else
    echo "Error: rsync operation failed."`
    exit 1
fi

