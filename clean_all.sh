#!/bin/sh

# Runs each clean script in the clean/directory

script_dir=$(dirname $0)

for ps in lrat lpr lsr ; do
  ${script_dir}/clean/clean_${ps}.sh
done