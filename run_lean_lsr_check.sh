#!/bin/sh

checker=lean-lsr-check

if [ -f ./${checker} ]; then
  # The Lean checker is a large executable,
  # so to cache it in memory,
  # run it once to get the usage string.
  ./lean-lsr-check > /dev/null
  ./run_checker_base.sh ${checker} . pr
  ./run_checker_base.sh ${checker} . sr
else
  echo "Error: ./${checker} does not exist."
  echo "Because the Lean executable is too large, and Lean installation is complicated, you must add it manually."
  echo "Please move a copy to './${checker}'."
  exit 1
fi