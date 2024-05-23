#!/bin/sh

# Runs all labeled-proof checkers, and records their runtimes.
# If the Lean checker is not included, skips it.
# This script expects to be at the root level of the project.

starting_dir=$(pwd)
script_dir=$(dirname $0)

${script_dir}/run/run_lpr_check.sh
${script_dir}/run/run_lsr_check.sh
${script_dir}/run/run_cake_lpr.sh

if [ -f ${script_dir}/${lean_dir}/${lean_checker} ]; then
  ${script_dir}/run/run_lean_lsr_check.sh
else
  echo "Lean checker doesn't exist, skipping..."
end

cd $starting_dir