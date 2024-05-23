#!/bin/sh

# Runs cake_lpr on the generated LRAT/LPR proofs.

echo "Running cake_lpr on all .lpr proofs"
echo "NOTE: Checking all proofs takes about 20 minutes in total"

script_dir=$(dirname $0)
$script_dir/run_checker_base.sh cake_lpr cake_lpr pr-proofs pr
$script_dir/run_checker_base.sh cake_lpr cake_lpr sr-proofs rat

echo "Finished running lpr-check on all .lpr and .lrat proofs"