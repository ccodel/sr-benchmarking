#!/bin/sh

# Runs lsr-check on the generated LRAT/LPR/LSR proofs.

./run_checker_base.sh lsr-check dsr-trim pr
./run_checker_base.sh lsr-check dsr-trim sr