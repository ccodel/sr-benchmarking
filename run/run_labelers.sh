#!/bin/sh

script_dir=$(dirname $0)

# NOTE: The scripts have underscores, but the checkers use hyphens
for labeler in dpr_trim dsr_trim ; do
  $script_dir/run_${labeler}.sh
done
