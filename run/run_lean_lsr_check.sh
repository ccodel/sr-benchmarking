#!/bin/sh

# Runs the Lean checker on the specified proof system.
# See run_checker_base.sh
# Usage: ./run_lean_lsr_check <proof_system>

starting_dir=$(pwd)
script_dir=$(dirname $0)

checker=lean-lsr-check
checker_dir=.
ps=${1}

cd $script_dir/..

if [ -f ${checker_dir}/${checker} ]; then
  # The Lean checker is a large executable,
  # so to cache it in memory,
  # run it once to get the usage string.
  ${checker_dir}/${checker} > /dev/null
  run/run_checker_base.sh ${checker} ${checker_dir} sr-proofs $ps
else
  echo "Error: ${checker_dir}/${checker} does not exist."
  echo "Because the Lean executable is too large, and Lean installation is complicated, you must add it manually."
  echo "Please move a copy to './${checker}'."
  cd $starting_dir
  exit 1
fi

cd $starting_dir