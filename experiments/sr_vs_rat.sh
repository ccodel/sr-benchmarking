#!/bin/sh

# Assumes that all LSR files have been labeled.
# Experiment 2: Proof size comparison between LSR and converted LRAT proofs
# Experiment 3: Proof checking times on LSR and converted LRAT proofs

starting_dir=$(pwd)
script_dir=$(dirname $0)

lean_checker=lean-lsr-check
lean_dir=.
cake_dir=cake_lpr
cake_lpr=cake_lpr
sr2drat_dir=sr2drat
sr2drat=sr2drat
proof_dir=sr-proofs
ps=sr

# First, check to make sure the checkers exist
cd $script_dir/..
for checker in "${lean_dir}/${lean_checker}" "${cake_dir}/${cake_lpr}" "${sr2drat_dir}/${sr2drat}" ; do
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

# Now run sr2drat on all SR files.
echo "Running sr2drat on all SR files to generate DRAT proofs"
run/run_sr2drat.sh
cd $script_dir/..

# Run the Lean checker and cake on the relevant proof files
echo "Running cake_lpr on the generated LRAT proofs"
run/run_checker_base.sh ${cake_lpr} ${cake_dir} ${proof_dir} rat
cd $script_dir/..

echo "Running lean-lsr-check on the generated LSR proofs"
run/run_checker_base.sh ${lean_checker} ${lean_dir} ${proof_dir} ${ps}
cd $starting_dir