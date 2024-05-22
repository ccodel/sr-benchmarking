#!/bin/sh

# Runs drat-trim on all DRAT files in both pr-proofs and sr-proofs

echo "Running drat-trim on all .drat proofs in the sr-proofs directory"
echo "NOTE: Generating all proofs takes about 5 minutes in total"

script_dir=$(dirname $0)
$script_dir/run_labeler_base.sh drat-trim drat-trim sr-proofs drat

echo "Finished running drat-trim on all .drat proofs"