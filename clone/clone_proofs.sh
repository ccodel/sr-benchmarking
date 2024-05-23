#!/bin/sh

# Clones the proof repositories.
# This script expects to be in the clone/ directory.
# If any of the following directories already exist at project root level:
#    ./sr-proofs
#    ./pr-proofs
# then instead it will `git pull`.

# Save the starting directory, restore when done
starting_dir=$(pwd)
script_dir=$(dirname $0)

cd $script_dir/..

for proofs in sr-proofs pr-proofs ; do
  if [ ! -d ./${proofs} ]; then
    git clone https://github.com/marijnheule/${proofs}
  else
    echo "./${proofs} already exists, pulling latest changes..."
    cd ${proofs}
    git pull
    cd ..
  fi
done

echo "------------------------------"
echo "All proof repositories cloned."
echo "------------------------------"

cd $starting_dir