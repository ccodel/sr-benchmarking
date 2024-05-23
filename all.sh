#!/bin/sh

# Runs all the *_all.sh scripts, in the correct order.
# Clones and builds the repositories, labels all the proofs, runs the experiments, and removes the labeled proofs.
# Will not run if the Lean checker is not provided.
# This script expects to be at the root level of the project.

script_dir=$(dirname $0)

lean_checker=lean-lsr-check
lean_dir=.

if [ ! -f ${script_dir}/${lean_dir}/${lean_checker} ]; then
  echo "Error: Will not run everything until the Lean checker is provided at ${lean_dir}/${lean_checker}."
  exit 1
fi

for s in clone build label check collate clean ; do
  ${script_dir}/${s}_all.sh
done