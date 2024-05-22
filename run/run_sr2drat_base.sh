#!/bin/sh

# Transforms all SR proofs in sr-proofs into DRAT proofs using sr2drat.
# Then transforms those into LRAT with drat-trim.
# Collects file sizes too.
# Usage: ./run_sr2drat.sh <proof_dir> <ps>

starting_dir=$(pwd)
script_dir=$(dirname $0)

checker=sr2drat
checker_dir=sr2drat
drat_trim=drat-trim
drat_trim_dir=drat-trim
file_sizes=file-sizes

proof_dir=${1}
ps=${2}

mkdir -p results
mkdir -p results/${checker}
mkdir -p results/${drat_trim}
mkdir -p results/${file_sizes}

if [ ! -d ${checker_dir} ]; then
  echo "Error: ./${checker_dir} does not exist. Run clone/clone_checkers.sh."
  cd $starting_dir
  exit 1
fi

if [ ! -f ${checker_dir}/${checker} ]; then
  echo "Error: ./${checker_dir}/${checker} does not exist, try running ./build/build_checkers.sh."
  cd $starting_dir
  exit 1
fi

if [ ! -d ${drat_trim_dir} ]; then
  echo "Error: ./${drat_trim_dir} does not exist. Run clone/clone_checkers.sh."
  cd $starting_dir
  exit 1
fi

if [ ! -f ${drat_trim_dir}/${drat_trim} ]; then
  echo "Error: ./${drat_trim_dir}/${drat_trim} does not exist, try running ./build/build_checkers.sh."
  cd $starting_dir
  exit 1
fi

if [ ! -d ${proof_dir} ]; then
  echo "Error: ./${proof_dir} does not exist. Run clone/clone_proofs.sh."
  cd $starting_dir
  exit 1
fi

echo "Running ${checker} on each .${ps} proof with a labeled proof"
 
cd $proof_dir

# Along the way, for each CNF, DSR, and LSR file, record its file size
csv=../results/${file_sizes}/${checker}_${ps}_conversion_file_sizes.csv
echo "cnf_name,cnf_size_kb,${ps}_size_kb,l${ps}_size_kb,drat_size_kb,lrat_size_kb,cnf_lc,${ps}_lc,l${ps}_lc,drat_lc,lrat_lc" > ${csv}

for dir in $(ls -d */); do
  for cnf_file in ./${dir}/*.cnf; do
    f=$(basename ${cnf_file} .cnf)

    # Only run the checker if a labeled proof file exists for the CNF
    if [ -f ./${dir}/${f}.${ps} ] && [ -f ./${dir}/${f}.l${ps} ]; then
      echo "Running ${checker} on ${f}.${ps}"

      # Make collate_results.py happy by inserting a "VERIFIED" string,
      # even though we are only suppling a formula transformation.
      results_file=../results/${checker}/${f}.${ps}.txt
      echo "s VERIFIED" > $results_file
      { time ../${checker_dir}/${checker} ${dir}/${f}.cnf ${dir}/${f}.${ps} > ${dir}/${f}.drat ; }  \
        2>> $results_file 

      # Now run drat-trim on the generated DRAT proof (with backwards trimming)
      drat_results_file=../results/${drat_trim}/${f}.${checker}.txt
      echo "  Running drat-trim on the generated DRAT proof"
      { time ../${drat_trim_dir}/${drat_trim} ${dir}/${f}.cnf ${dir}/${f}.drat -L ${dir}/${f}.lrat \
        > $drat_results_file ; }  \
        2>> $drat_results_file 

      cnf_size=$(du -k ${dir}/${f}.cnf | cut -f1)
      d_size=$(du -k ${dir}/${f}.${ps} | cut -f1)
      l_size=$(du -k ${dir}/${f}.l${ps} | cut -f1)
      drat_size=$(du -k ${dir}/${f}.drat | cut -f1)
      lrat_size=$(du -k ${dir}/${f}.lrat | cut -f1)
      cnf_lc=$(wc -l < ${dir}/${f}.cnf | tr -d ' ')
      d_lc=$(wc -l < ${dir}/${f}.${ps} | tr -d ' ')
      l_lc=$(wc -l < ${dir}/${f}.l${ps} | tr -d ' ')
      drat_lc=$(wc -l < ${dir}/${f}.drat | tr -d ' ')
      lrat_lc=$(wc -l < ${dir}/${f}.lrat | tr -d ' ')

      # Output file sizes, including LRAT proof, to the CSV file
      echo "${f},${cnf_size},${d_size},${l_size},${drat_size},${lrat_size},${cnf_lc},${d_lc},${l_lc},${drat_lc},${lrat_lc}" >> ${csv}
    fi
  done
done

cd $starting_dir