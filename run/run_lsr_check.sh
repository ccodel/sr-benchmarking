#!/bin/sh

# Runs lpr-check on the generated LRAT/LPR/LSR proofs.

echo "Running lsr-check on all .lpr and .lsr proofs"
echo "NOTE: Checking all proofs takes about 4 minutes in total"

script_dir=$(dirname $0)
$script_dir/run_checker_base.sh lsr-check dsr-trim pr-proofs pr
$script_dir/run_checker_base.sh lsr-check dsr-trim sr-proofs sr

echo "Finished running lsr-check on all .lpr and .lsr proofs"