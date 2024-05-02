#!/bin/sh

# Runs the specified hinted checker on the specified proof directory.
# Usage: ./run_checker_base.sh <checker> <checker_dir> <proof_system>

checker=${1}
checker_dir=${2}
ps=${3}

mkdir -p results
mkdir -p results/${checker}

if [ -d ${checker_dir} ]; then
  if [ ! -f ./${checker_dir}/${checker} ]; then
    cd ${checker_dir}
    make clean && make
    cd ..
  fi

  if [ -d ./${ps}-proofs ]; then
    cd ${ps}-proofs

    for dir in $(ls -d */); do
      for cnf_file in ./${dir}/*.cnf; do
        f=$(basename ${cnf_file} .cnf)

        if [ -f ./${dir}/${f}.l${ps} ]; then
          echo "Running ${checker} on ${f}.l${ps}"
          { time ../${checker_dir}/${checker} ${dir}/${f}.cnf ${dir}/${f}.l${ps} \
            > ../results/${checker}/${checker}-${f}.${ps}.txt ; }  \
            2>> ../results/${checker}/${checker}-${f}.${ps}.txt
        else
          echo "No .l${ps} file for ${f}.cnf. Run ./run_d${ps}_trim.sh?"
        fi
      done
    done
    cd ..
  else
    echo "Error: ./${proof_dir} does not exist. Try running ./clone_proofs.sh."
    exit
  fi
else
  echo "Error: ./${checker_dir} does not exist. Try running ./clone_checkers.sh."
  exit
fi