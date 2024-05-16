#!/bin/sh

# Builds/compiles all the checkers and proofs.

script_dir=$(dirname $0)

$script_dir/build/build_checkers.sh
$script_dir/build/build_proofs.sh