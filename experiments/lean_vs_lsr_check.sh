#!/bin/sh

# Runs the verified Lean checker and the unverified lsr-check on LSR proofs
# If the .lsr proofs haven't been generated yet, generates them

starting_dir=$(pwd)
script_dir=$(dirname $0)

lean_checker=lean-lsr-check
lean_dir=.
lsr_check=lsr-check
lsr_check_dir=dsr-trim
proof_dir=sr-proofs
ps=sr

# First, check to make sure the checkers exist
cd $script_dir/..
for checker in "${lean_dir}/${lean_checker}" "${lsr_check_dir}/${lsr_check}" ; do
  if [ ! -f $checker ]; then
    echo "Error: $checker does not exist"
    echo "Try compiling the checker, or manually installing an executable"
    cd $starting_dir
    exit 1
  fi
done

if [ ! -d $proof_dir ]; then
  echo "Error: $proof_dir does not exist"
  echo "Try running clone/clone_proofs.sh"
  cd $starting_dir
  exit 1
fi

# If the LSR proofs haven't been generated yet, do so now
if [ ! -f sr-proofs/packing/packing-5-10-5.lsr ]; then
  echo "LSR proofs haven't been generated yet, doing so now"
  run/run_dsr_trim.sh
  cd $script_dir/..
else
  echo "LSR proofs have been generated, skipping..."
fi

# Run the Lean checker and lsr-check on the relevant proof files
echo "Running lsr-check on the generated LSR proofs"
run/run_checker_base.sh ${lsr_check} ${lsr_check_dir} ${proof_dir} ${ps}
cd $script_dir/..

echo "Running lean-lsr-check on the generated LSR proofs"
${lean_dir}/${lean_checker} > /dev/null   # Load executable into memory
run/run_checker_base.sh ${lean_checker} ${lean_dir} ${proof_dir} ${ps}
cd $starting_dir