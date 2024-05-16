#!/bin/sh

# Transforms all SR proofs in sr-proofs into DRAT proofs using ppr2drat.
# Collects file sizes too.

checker=ppr2drat
checker_dir=ppr2drat

mkdir -p results
mkdir -p results/${checker}
mkdir -p results/drat-trim
mkdir -p results/file-sizes

if [ -d ./sr-proofs ] && [ -d ./${checker_dir} ]; then
  if [ ! -f ./${checker_dir}/${checker} ]; then
    cd ${checker_dir}
    make clean && make
    cd ..
  fi

  cd sr-proofs
  
  # Along the way, for each CNF, DSR, and LSR file, record its file size
  csv=../results/file-sizes/ppr2drat_file_sizes.csv
  echo "cnf_name,cnf_size_kb,dsr_size_kb,lsr_size_kb,drat_size_kb" > ${csv}

  for dir in $(ls -d */); do
    for cnf_file in ./${dir}/*.cnf; do
      f=$(basename ${cnf_file} .cnf)

      if [ -f ./${dir}/${f}.sr ]; then
        echo "Running ${checker} on ${f}"

        # Make collate_results.py happy by inserting a "VERIFIED" string,
        # even though we are only suppling a formula transformation.
        echo "s VERIFIED" > ../results/${checker}/${checker}-${f}.sr.txt
        { time ../${checker_dir}/${checker} ${dir}/${f}.cnf ${dir}/${f}.sr > ${dir}/${f}.drat ; }  \
          2>> ../results/${checker}/${checker}-${f}.sr.txt

        cnf_size=$(du -k ${dir}/${f}.cnf | cut -f1)
        dsr_size=$(du -k ${dir}/${f}.sr | cut -f1)
        lsr_size=$(du -k ${dir}/${f}.lsr | cut -f1)
        drat_size=$(du -k ${dir}/${f}.drat | cut -f1)

        echo "${f},${cnf_size},${dsr_size},${lsr_size},${drat_size}" >> ${csv}

        # Now run drat-trim on the generated DRAT proof
        echo "  Running drat-trim on the generated DRAT proof"
        { time ../drat-trim/drat-trim ${dir}/${f}.cnf ${dir}/${f}.drat  \
          > ../results/drat-trim/drat-trim-${f}.sr2drat.txt ; }  \
          2>> ../results/drat-trim/drat-trim-${f}.sr2drat.txt
      fi
    done
  done

  cd ..
else
  echo "Error: ./sr-proofs does not exist."
  exit
fi
