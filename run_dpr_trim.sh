#!/bin/sh

# Runs ./dpr-trim on all LPR files in ./pr-proofs.
# Times how long proof generation takes.
# Uses backwards proof checking.

checker=dpr-trim
checker_dir=dpr-trim

mkdir -p results
mkdir -p results/${checker}
mkdir -p results/file-sizes

if [ -d ./pr-proofs ] && [ -d ./${checker} ]; then
  if [ ! -f ./${checker_dir}/${checker} ]; then
    cd ${checker_dir}
    make clean && make
    cd ..
  fi

  cd pr-proofs
  
  # Along the way, for each CNF, DSR, and LPR file, record its file size
  csv=../results/file-sizes/pr_file_sizes.csv
  echo "cnf_name,cnf_size_kb,dpr_size_kb,lpr_size_kb" > ${csv}

  for dir in $(ls -d */); do
    for cnf_file in ./${dir}/*.cnf; do
      f=$(basename ${cnf_file} .cnf)

      if [ -f ./${dir}/${f}.pr ]; then
        echo "Running ${checker} on ${f}.pr"
        { time ../${checker_dir}/${checker} ${dir}/${f}.cnf ${dir}/${f}.pr -L ${dir}/${f}.lpr  \
          > ../results/${checker_dir}/${checker}-${f}.txt ; }  \
          2>> ../results/${checker_dir}/${checker}-${f}.pr.txt

        cnf_size=$(du -k ${dir}/${f}.cnf | cut -f1)
        dpr_size=$(du -k ${dir}/${f}.pr | cut -f1)
        lpr_size=$(du -k ${dir}/${f}.lpr | cut -f1)

        echo "${f},${cnf_size},${dpr_size},${lpr_size}" >> ${csv}
      fi
    done
  done

  cd ..
else
  echo "Error: ./pr-proofs does not exist."
  exit
fi