#!/bin/sh

# Clones the proof repositories.
# If any of the following directories already exist at project root level:
#    ./sr-proofs
#    ./pr-proofs
# then instead it will `git pull`.

for proofs in sr-proofs pr-proofs ; do
  if [ ! -d ./sr-proofs ]; then
    git clone https://github.com/marijnheule/${proofs}
  else
    echo "./${proofs} already exists, pulling latest changes..."
    cd ${proofs}
    git pull
    cd ..
  fi
done
