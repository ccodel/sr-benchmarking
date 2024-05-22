#!/bin/sh

# Runs ./dpr-trim on all LPR files in ./pr-proofs.
# Times how long proof generation takes.
# Uses backwards proof checking.

echo "Running dpr-trim on all .pr proofs"
echo "NOTE: Generating all proofs takes about 15 minutes in total"

script_dir=$(dirname $0)
$script_dir/run_labeler_base.sh dpr-trim dpr-trim pr-proofs pr

echo "Finished running dpr-trim on all .pr proofs"