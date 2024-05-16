#!/bin/sh

# Runs the specified hinted checker on the specified proof directory.
# Times how long checking takes.
# Stores results in the results/ directory.
# Usage: ./run_checker_base.sh <checker> <checker_dir> <proof_system>

starting_dir=$(pwd)
script_dir=$(dirname $0)

checker=${1}
checker_dir=${2}
ps=${3}

cd $script_dir/..

mkdir -p results
mkdir -p results/${checker}

if [ -d ${checker_dir} ]; then
  if [ ! -f ./${checker_dir}/${checker} ]; then
    echo "${checker} does not exist, try running ./build/build_checkers.sh."
    cd $starting_dir
    exit 1
  fi

  if [ -d ./${ps}-proofs ]; then
    cd ${ps}-proofs

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
    cd ..
  else
    echo "Error: ./${proof_dir} does not exist. Try running ./clone_proofs.sh."
    cd $starting_dir
    exit 1
  fi
else
  echo "Error: ./${checker_dir} does not exist. Try running ./clone_checkers.sh."
  cd $starting_dir
  exit 1
fi

cd $starting_dir