#!/bin/sh

# Runs the labelers for PR and SR proofs

script_dir=$(dirname $0)

echo "Running dpr-trim on .pr proofs"
$script_dir/run/run_dpr_trim.sh

echo "Running dsr-trim on .sr proofs"
$script_dir/run/run_dsr_trim.sh

echo "Running sr2drat on .sr proofs"
$script_dir/run/run_sr2drat.sh