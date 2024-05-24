#!/bin/sh

# Labels smaller PR and SR files

script_dir=$(dirname $0)
$script_dir/run/run_labeler_quick.sh dpr-trim dpr-trim pr-proofs pr
$script_dir/run/run_labeler_quick.sh dsr-trim dsr-trim sr-proofs sr
$script_dir/run/run_sr2drat.sh