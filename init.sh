#!/bin/bash -e
# Run in exercise directory by exutil

exercise="$(basename $(pwd))"
filename="${exercise//-/_}.sh"
echo "Creating $filename..."
cp ../template.sh "$filename"