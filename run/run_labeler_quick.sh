#!/bin/sh

# A clone of run_labeler_base that skips mchess-50.pr and M10.pr

starting_dir=$(pwd)
script_dir=$(dirname $0)

checker=${1}
checker_dir=${2}
proof_dir=${3}
ps=${4}

cd $script_dir/..

mkdir -p results
mkdir -p results/${checker}
mkdir -p results/file-sizes

if [ ! -d ./${checker_dir} ]; then
  echo "Error: ./${checker_dir} does not exist. Run clone/clone_checkers.sh."
  cd $starting_dir
  exit 1
fi

if [ ! -f ./${checker_dir}/${checker} ]; then
  echo "${checker} does not exist, try running ./build/build_checkers.sh."
  cd $starting_dir
  exit 1
fi

if [ ! -d ./${proof_dir} ]; then
  echo "Error: ./${proof_dir} does not exist. Run clone/clone_proofs.sh."
  cd $starting_dir
  exit 1
fi

# All directories/executables exist, so start running the labeler

cd $proof_dir

csv=../results/file-sizes/${ps}_file_sizes.csv
echo "cnf_name,cnf_size_kb,${ps}_size_kb,l${ps}_size_kb,cnf_lc,${ps}_lc,l${ps}_lc" > ${csv}

for dir in $(ls -d */); do
  for cnf_file in ./${dir}/*.cnf; do
    f=$(basename ${cnf_file} .cnf)

    # Only run the checker if a proof file exists for the CNF
    if [ -f ./${dir}/${f}.${ps} ] && [ ! $f = "mchess-40" ] && [ ! $f = "mchess-50" ] && [ ! $f = "M9" ] && [ ! $f = "M10" ]; then
      echo "Running ${checker} on ${f}.${ps}"

      results_file=../results/${checker}/${f}.${ps}.txt
      if [ ${checker} = "dpr-trim" ] || [ ${checker} = "drat-trim" ]; then
        { time ../${checker_dir}/${checker} ${dir}/${f}.cnf ${dir}/${f}.${ps} -L ${dir}/${f}.l${ps} \
          > $results_file ; } \
          2>> $results_file
      else
        { time ../${checker_dir}/${checker} ${dir}/${f}.cnf ${dir}/${f}.${ps} ${dir}/${f}.l${ps} \
          > $results_file ; } \
          2>> $results_file
      fi

      cnf_size=$(du -k ${dir}/${f}.cnf | cut -f1)
      d_size=$(du -k ${dir}/${f}.${ps} | cut -f1)
      l_size=$(du -k ${dir}/${f}.l${ps} | cut -f1)
      cnf_lc=$(wc -l < ${dir}/${f}.cnf | tr -d ' ')
      d_lc=$(wc -l < ${dir}/${f}.${ps} | tr -d ' ')
      l_lc=$(wc -l < ${dir}/${f}.l${ps} | tr -d ' ')

      echo "${f},${cnf_size},${d_size},${l_size},${cnf_lc},${d_lc},${l_lc}" >> ${csv}
    fi
  done
done

cd $starting_dir