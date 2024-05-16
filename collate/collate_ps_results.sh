#!/bin/sh

# A clone of collate_results.sh, except only taking results from a single proof system for checkers.

ps=${1}
mkdir -p results
mkdir -p results/collated

for checker in cake_lpr lrat-check lpr-check lsr-check lean-lsr-check ; do
  if [ -d ./results/${checker} ]; then
    
    csv=results/collated/${checker}-${ps}-collated.csv
    echo "checker-file,time" > ${csv}

    echo "Collating results for ${checker} in ${csv}"
    counter=0
    for file in results/${checker}/*.${ps}.txt ; do
      if [ -f $file ]; then
        python3 collate_results.py $file >> $csv
        ((counter++))
      fi
    done

    if [ ${counter} -eq 0 ]; then
      rm ${csv}
    fi
  else
    echo "No results found for ${checker}, skipping..."
  fi
done