#!/bin/sh

# Runs lpr-check on the generated LRAT/LPR proofs.

echo "Running lpr-check on all .lpr proofs"
echo "NOTE: Checking all proofs takes about 2 minutes in total"

script_dir=$(dirname $0)
$script_dir/run_checker_base.sh lpr-check dpr-trim pr

echo "Finished running lpr-check on all .lpr proofs"