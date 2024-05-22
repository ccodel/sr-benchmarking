#!/bin/sh

# Runs sr2drat on the SR proofs in sr-proofs.

starting_dir=$(pwd)
script_dir=$(dirname $0)
$script_dir/run_sr2drat_base.sh sr-proofs sr

echo "All done with SR proof conversion"
cd $starting_dir