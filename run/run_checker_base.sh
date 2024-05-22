#!/bin/sh

# Runs the specified hinted checker on the specified proof system.
# Times how long checking takes.
# Stores results in the results/ directory.
# Usage: ./run_checker_base.sh <checker> <checker_dir> <proof_dir> <proof_system>

starting_dir=$(pwd)
script_dir=$(dirname $0)

checker=${1}
checker_dir=${2}
proof_dir=${3}
ps=${4}

cd $script_dir/..

mkdir -p results
mkdir -p results/${checker}

if [ ! -d ${checker_dir} ]; then
  echo "Error: ./${checker_dir} does not exist. Try running ./clone/clone_checkers.sh."
  cd $starting_dir
  exit 1
fi

if [ ! -f ./${checker_dir}/${checker} ]; then
  echo "Error: ${checker_dir}/${checker} does not exist, try running ./build/build_checkers.sh."
  cd $starting_dir
  exit 1
fi

if [ ! -d ./${proof_dir} ]; then
  echo "Error: ./${proof_dir} does not exist. Try running ./clone/clone_proofs.sh."
  cd $starting_dir
  exit 1
fi

cd $proof_dir

for dir in $(ls -d */); do
  for cnf_file in ./${dir}/*.cnf; do
    f=$(basename ${cnf_file} .cnf)

    # Only run the checker if a proof file exists for the CNF
    if [ -f ./${dir}/${f}.l${ps} ]; then
      echo "Running ${checker} on ${f}.l${ps}"

      results_file=../results/${checker}/${f}.l${ps}.txt
      { time ../${checker_dir}/${checker} ${dir}/${f}.cnf ${dir}/${f}.l${ps} \
        > $results_file ; }  \
        2>> $results_file
    fi
  done
done

cd $starting_dir