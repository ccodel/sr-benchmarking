#!/bin/sh

# Clones the proof checkers.
# This script expects to be in the clone/ directory.
# If any of the following directories already exist at project root level:
#    ./drat-trim/
#    ./dpr-trim/
#    ./cake_lpr/
#    ./dsr-trim/
#    ./ppr2drat/
# then instead it will `git pull`.

# Save the starting directory, restore when done
starting_dir=$(pwd)
script_dir=$(dirname $0)

# Change to this script's directory, then up a level, to project root
cd $script_dir/..

for checker in drat-trim dpr-trim sr2drat ; do
  if [ ! -d ./${checker} ]; then
    git clone https://github.com/marijnheule/${checker}
  else
    echo "./${checker} already exists, pulling latest changes..."
    cd ${checker}
    git pull
    cd ..
  fi
done

if [ ! -d ./cake_lpr ]; then
  git clone https://github.com/tanyongkiam/cake_lpr
else
  echo "./cake_lpr already exists, pulling latest changes..."
  cd cake_lpr
  git pull
  cd ..
fi

if [ ! -d ./dsr-trim ]; then
  git clone https://github.com/ccodel/dsr-trim
else
  echo "./dsr-trim already exists, pulling latest changes..."
  cd dsr-trim
  git pull
  cd ..
fi

echo "--------------------------"
echo "All proof checkers cloned."
echo "--------------------------"

cd $starting_dir