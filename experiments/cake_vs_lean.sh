#!/bin/sh

# Assumes that all desired LPR files have been created.
# To label them, call run/run_dpr_trim.sh, or ./label_all.sh.
# Experiment 1: Runtime comparison on LPR files
#  cake_lpr vs. verified Lean checker

starting_dir=$(pwd)
script_dir=$(dirname $0)

lean_dir=.
lean_checker=lean-lsr-check
cake_dir=cake_lpr
cake_lpr=cake_lpr

# First, check to make sure the checkers exist
cd $script_dir/..
for checker in "${lean_dir}/${lean_checker}" "${cake_dir}/${cake_lpr}" ; do
  if [ ! -f $checker ]; then
    echo "Error: $checker does not exist."
    echo "Run ./build_checkers.sh, or manually install an executable."
    cd $starting_dir
    exit 1
  fi
done

echo "Running cake_lpr on all existing LPR proofs"
run/run_cake_lpr.sh

echo "Running lean-lsr-check on all existing LPR proofs"
run/run_checker_base.sh ${lean_checker} ${lean_dir} pr-proofs pr

cd $starting_dir