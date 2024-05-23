#!/bin/sh

# Builds any proofs that require scripting to compute.
# This script expects to be in the build/ directory.
# Assumes that `./clone_proofs.sh` has already been run.

# Save the starting directory, restore when done
starting_dir=$(pwd)
script_dir=$(dirname $0)

cd $script_dir/..

# No proofs need to be script-built for pr-proofs, so nothing to do here
if [ ! -d ./pr-proofs ]; then
  echo "Error: ./pr-proofs does not exist."
  cd $starting_dir
  exit
fi

if [ ! -d ./sr-proofs ]; then
  echo "Error: ./sr-proofs does not exist."
  cd $starting_dir
  exit 1
fi

cd sr-proofs/php
if [ ! -f php-50.sr ]; then
  echo "Building php and php-sr proof generation executables..."
  make clean > /dev/null
  make > /dev/null
  if [ -f ./php ] && [ -f ./php-sr ]; then
    for i in $(seq 10 5 50); do
      echo "Generating php-${i}"
      ./php $i > php-${i}.cnf
      ./php-sr $i > php-${i}.sr
    done
  else
    echo "Error: ./php or ./php-sr does not exist."
    cd $starting_dir
    exit 1
  fi
else
  echo "php and php-sr proofs already generated, skipping..."
fi

cd $starting_dir