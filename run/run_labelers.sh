#!/bin/sh

script_dir=$(dirname $0)

for labeler in dpr-trim dsr-trim ; do
  $script_dir/run_${labeler}.sh
done
