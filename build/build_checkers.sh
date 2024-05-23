#!/bin/sh

# (Re)compiles each of the proof checkers.
# This script expects to be in the build/ directory.
# It assumes that `./clone_checkers.sh` has already been run,
# and that the following directories exist
# and are at the most recent commit on `main`:
#    ./drat-trim/
#    ./dpr-trim/
#    ./cake_lpr/
#    ./dsr-trim/
#    ./sr2drat/

# Save the starting directory, restore when done
starting_dir=$(pwd)
script_dir=$(dirname $0)

cd $script_dir/..

for checker in drat-trim dpr-trim cake_lpr dsr-trim sr2drat ; do
  if [ -d ./${checker} ]; then
    echo "Building ${checker}..."
    cd $checker
    if [ -f $checker ]; then
      echo "${checker} already exists, skipping"
    else
      make > /dev/null

      # If any checker (particularly cake_lpr) encounters build error...
      if [ $? -ne 0 ]; then
        echo "------- build_checkers.sh ----------"
        echo "Error: '${checker}' encountered a build error."
        echo "If the checker above is cake_lpr, you may be running on an ARM machine."
        echo "Go to ./cake_lpr and uncomment the "cake_lpr_arm8" lines in the Makefile."
        echo "Then manually run 'make cake_lpr_arm8'."
        echo "------- build_checkers.sh ---------"
      fi
    fi

    cd ..
  else
    echo "Error: ./${checker} does not exist. Try running ./clone_checkers.sh."
    cd $starting_dir
    exit 1
  fi
done

cd $starting_dir