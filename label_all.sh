#!/bin/sh

# Runs the labelers for PR and SR proofs

script_dir=$(dirname $0)
$script_dir/run/run_dpr_trim.sh
$script_dir/run/run_dsr_trim.sh