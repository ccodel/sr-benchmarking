#!/bin/sh

# Runs each clean script in the clean/directory

script_dir=$(dirname $0)

# NOTE: This will remove all sr2drat .drat proofs
# But if ANY proof directory contains .drat files, they will be removed too.
for ps in drat lrat lpr lsr ; do
  ${script_dir}/clean/clean_${ps}.sh
done