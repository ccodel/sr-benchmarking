#!/bin/sh

# Removes specified proof files from the specified proof directory.
# Usage: ./clean_base.sh <proof_dir> <proof_system>
# This script expects to be in the clean/ directory.

starting_dir=$(pwd)
script_dir=$(dirname $0)

proof_dir=${1}
ps=${2}

cd $script_dir/..
if [ ! -d ./${proof_dir} ]; then
  echo "Error: The proof directory ${proof_dir} does not exist."
  cd $starting_dir
  exit 1
fi

cd $proof_dir
for dir in $(ls -d */); do
  rm -f ./${dir}/*.${ps}
done

cd $starting_dir