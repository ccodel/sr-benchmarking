#!/bin/sh

# Runs collate_results.py on all results in
#   results/drat-trim
#   results/dpr-trim
#   results/cake_lpr
#   results/dsr-trim
#   results/sr2drat
#   results/lrat-check
#   results/lpr-check
#   results/lsr-check
#   results/lean-lsr-check
# Stores collated results in results/collated

starting_dir=$(pwd)
script_dir=$(dirname $0)

cd $script_dir/..

mkdir -p results
mkdir -p results/collated

for checker in cake_lpr drat-trim dpr-trim dsr-trim sr2drat lrat-check lpr-check lsr-check lean-lsr-check ; do
  if [ -d ./results/${checker} ]; then
    
    csv=results/collated/${checker}-collated.csv
    echo "checker-file,time" > ${csv}

    echo "Collating results for ${checker} in ${csv}"
    for file in results/${checker}/*.txt ; do
      python3 collate_results.py $file >> $csv
    done
  else
    echo "No results found for ${checker}, skipping..."
  fi
done

cd $starting_dir
