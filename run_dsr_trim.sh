#!/bin/sh

# Runs ./dsr-trim on all LSR files in ./sr-proofs.
# Times how long proof generation takes

mkdir -p results
mkdir -p results/dsr-trim
mkdir -p results/file-sizes

checker=dsr-trim

if [ -d ./sr-proofs ] && [ -d ./${checker} ]; then
  if [ ! -f ./${checker}/${checker} ]; then
    cd ${checker}
    make clean && make
    cd ..
  fi

  cd sr-proofs
  
  # Along the way, for each CNF, DSR, and LSR file, record its file size
  csv=../results/file-sizes/sr_file_sizes.csv
  echo "cnf_name,cnf_size_kb,dsr_size_kb,lsr_size_kb" > ${csv}

  for dir in $(ls -d */); do
    for cnf_file in ./${dir}/*.cnf; do
      f=$(basename ${cnf_file} .cnf)

      if [ -f ./${dir}/${f}.sr ]; then
        echo "Running ${checker} on ${f}"
        { time ../${checker}/${checker} ${dir}/${f}.cnf ${dir}/${f}.sr ${dir}/${f}.lsr  \
          > ../results/${checker}/${checker}-${f}.txt ; }  \
          2>> ../results/${checker}/${checker}-${f}.sr.txt

        cnf_size=$(du -k ${dir}/${f}.cnf | cut -f1)
        dsr_size=$(du -k ${dir}/${f}.sr | cut -f1)
        lsr_size=$(du -k ${dir}/${f}.lsr | cut -f1)

        echo "${f},${cnf_size},${dsr_size},${lsr_size}" >> ${csv}
      fi
    done
  done

  cd ..
else
  echo "Error: ./sr-proofs does not exist."
  exit
fi
