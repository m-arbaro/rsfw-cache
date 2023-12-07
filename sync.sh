#!/bin/bash

validate_args(){
EXPECTED_ARGS=2
if [ $# -ne $EXPECTED_ARGS ]; then
    echo "Usage: $0 source_dir dest_dir"
    return 1
fi

for arg in "$@"
do
    if [ ! -d "$arg" ]; then
        echo "Error: '$arg' is not a directory."
        return 1
    fi
done

}

sync_dest(){
OLD_PWD=$PWD
SOURCE_DIR=$1
DEST_DIR=$2
LOGGING="0"
cd "$SOURCE_DIR"
OLD_IFS="$IFS"
IFS=$'\n'
#syncing files
    
for f in $(find "." -type f |  sed 's/^\.\///' )
do
    f_n="$f"".$RANDOM"
    echo copying  "$f" to tmp file "$f_n"
    cp "$SOURCE_DIR"/"$f" "$DEST_DIR"/"$f_n"
    if [[ -L "$DEST_DIR"/"$f" ]]; then    
        echo removing symlink "$DEST_DIR"/"$f"
        rm "$DEST_DIR"/"$f"
    fi
    echo moving temp file where it belongs
    mv "$DEST_DIR"/"$f_n" "$DEST_DIR"/"$f"

done

IFS="$OLD_IFS"

echo sync done.
}   


#####MAIN#####  
set +x
validate_args $*
sync_dest $*
set -x 