#!/bin/sh

# Builds any proofs that require scripting to compute.
# Assumes that `./clone_proofs.sh` has already been run.

if [ ! -d ./pr-proofs ]; then
  echo "Error: ./pr-proofs does not exist."
  exit
fi

if [ -d ./sr-proofs ]; then
  cd sr-proofs/php
  make clean && make
  if [ -f ./php ] && [ -f ./php-sr ]; then
    for i in $(seq 10 5 50); do
      echo "Generating php-${i}"
      ./php $i > php-${i}.cnf
      ./php-sr $i > php-${i}.sr
    done
  else
    echo "Error: ./php or ./php-sr does not exist."
    exit
  fi

  cd ../..
else
  echo "Error: ./sr-proofs does not exist."
  exit
fi