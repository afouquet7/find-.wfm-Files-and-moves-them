#!/bin/bash

#==========================================================================================
# Script to find files and move them to a given path (in this case toDelete)
# The -exec {} is a find argument it returns the resault to {}.
# the + (plus sign) ensures that we runs as few mv operations as possible.
#
# Script Name: fileMover.sh
#
# Author: Alex Fouquet
# Date : 19.02.2020
#
#
# Run Information: run script with bin/bash from command line.
#
#
# Error Log: Any errors or output associated with the script will be displayed in termianl
#==========================================================================================

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  TARGET="$(readlink "$SOURCE")"
  if [[ $TARGET == /* ]]; then
    echo "SOURCE '$SOURCE' is an absolute symlink to '$TARGET'"
    SOURCE="$TARGET"
  else
    DIR="$( dirname "$SOURCE" )"
    echo "SOURCE '$SOURCE' is a relative symlink to '$TARGET' (relative to '$DIR')"
    SOURCE="$DIR/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  fi
done
echo "SOURCE is '$SOURCE'"
RDIR="$( dirname "$SOURCE" )"
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
if [ "$DIR" != "$RDIR" ]; then
  echo "DIR '$RDIR' resolves to '$DIR'"
fi


cd "$DIR" #shell session is now where this script is

#echo "My Directory is: $DIR"

mkdir toDelete #create directory where files will be moved to

toDelete=$DIR #passing toDelete directory to a variable to be used in the find command
toDelete=($DIR/toDelete) #adding the toDelete directory

#find .wfm files and moves them toDelete directory
find . -iname '*.wfm' -exec mv '{}' $toDelete \;
#find Session File Backups directorys and moves them toDelete directory
find . -name 'Session File Backups' -exec mv '{}' $toDelete \;

echo "your files have been moved!"
