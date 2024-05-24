#!/bin/sh

# Runs all the experiments.
# Assumes that the checkers and proofs have been cloned and built.

starting_dir=$(pwd)
script_dir=$(dirname $0)

echo "Labeling all proofs first (even if they've already been labeled.)"
$script_dir/run/run_dpr_trim.sh

echo "Running cake_lpr vs. Lean checker on PR families"
${script_dir}/experiments/cake_vs_lean.sh

echo "Running Lean vs. lsr-check on SR families"
${script_dir}/experiments/lean_vs_lsr_check.sh

echo "Running sr2drat on SR files"
${script_dir}/experiments/sr_vs_rat.sh

cd $starting_dir