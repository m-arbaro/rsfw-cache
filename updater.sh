#!/bin/bash

validate_args(){
EXPECTED_ARGS=3
if [ $# -ne $EXPECTED_ARGS ]; then
    echo "Usage: $0 FULL_PATH SOURCE_DIR DEST_DIR"
    exit 1
fi

if [ ! -d "$2" ]; then
    echo "Error: '$SOURCE_DIR' is not a directory."
    exit 1
fi

if [ ! -d "$2" ]; then
    echo "Error: '$SOURCE_DIR' is not a directory."
    exit 1
fi

}

FULL_PATH=$1
SOURCE_DIR=$2
DEST_DIR=$3
NEW_PATH=""

validate_args $*
NEW_PATH="$DEST_DIR""${FULL_PATH#$SOURCE_DIR}"

if [ -L $NEW_PATH ]; then
    rsync -a "$FULL_PATH" "$NEW_PATH"
    exit $?
else

    echo $NEW_PATH is not a symlink, aborting
    exit 1
fi