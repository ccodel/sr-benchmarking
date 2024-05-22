#!/bin/sh

# Runs ./dsr-trim on all LSR files in ./sr-proofs.
# Times how long proof generation takes

echo "Running dsr-trim on all .sr proofs"
echo "NOTE: Generating all proofs takes about 1 minute in total"

script_dir=$(dirname $0)
$script_dir/run_labeler_base.sh dsr-trim dsr-trim sr-proofs sr

echo "Finished running dsr-trim on all .sr proofs"