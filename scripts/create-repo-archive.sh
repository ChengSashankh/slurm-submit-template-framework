#!/bin/sh

echo "Running as $USER"
cd $HOME
echo "Current working directory: $PWD"

REPO=$1
OUTPUT_PATH=$2

echo "Provided repository path: $REPO"
echo "Output path: $OUTPUT_PATH"

echo "zip -r $OUTPUT_PATH $REPO"
zip -r $OUTPUT_PATH $REPO

if [ $? -eq 0 ]; then
   echo "Created archive successfully at: $OUTPUT_PATH"
   exit 0
else
   echo "Failed"
   exit 1
fi