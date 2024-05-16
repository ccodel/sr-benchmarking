#!/bin/sh

# Runs collate_results.py on all results in
#   results/drat-trim
#   results/dpr-trim
#   results/cake_lpr
#   results/dsr-trim
#   results/ppr2drat
# Stores collated results in results/collated

mkdir -p results
mkdir -p results/collated

for checker in drat-trim dpr-trim cake_lpr dsr-trim ppr2drat lrat-check lpr-check lsr-check lean-lsr-check ; do
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