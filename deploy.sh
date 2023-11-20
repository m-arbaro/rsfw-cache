#!/bin/bash

validate_args(){
EXPECTED_ARGS=2
if [ $# -ne $EXPECTED_ARGS ]; then
    echo "Usage: $0 source_dir dest_dir"
    exit 1
fi

for arg in "$@"
do
    if [ ! -d "$arg" ]; then
        echo "Error: '$arg' is not a directory."
        exit 1
    fi
done

if find $2 -mindepth 1 -maxdepth 1 | read; then
   echo "Destination dir is not empty"
   exit 1
fi

}

populate_dest(){
OLD_PWD=$PWD
SOURCE_DIR=$1
DEST_DIR=$2

#Deploying dir structure

cd $SOURCE_DIR
for DIR in $(find "."  -type d |  sed 's/^\.\///' )
do
    echo "$DIR"
    mkdir "$DEST_DIR"/"$DIR"
done

#Deploying links
    
for f in $(find "." -type f |  sed 's/^\.\///' )
do
    echo creating link "$f"; ln -s "$SOURCE_DIR"/"$f" "$DEST_DIR"/"$f"
done
}


#####MAIN#####
validate_args $*
populate_dest $*
