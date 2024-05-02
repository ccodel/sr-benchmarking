#!/bin/sh

# (Re)compiles each of the proof checkers.
# Assumes that `./clone_checkers.sh` has already been run,
# and that the following GitHub directories exist
# and are at the most recent commit on `main`:
#    ./drat-trim/
#    ./dpr-trim/
#    ./cake_lpr/
#    ./dsr-trim/
#    ./ppr2drat/

for checker in drat-trim dpr-trim cake_lpr dsr-trim ppr2drat ; do
  if [ -d ./${checker} ]; then
    cd $checker
    make clean
    make

    # If any checker (particularly cake_lpr) encounters build error...
    if [ $? -ne 0 ]; then
      echo "------- build_checkers.sh ----------"
      echo "Error: ${checker} encountered a build error."
      echo "If the checker is cake_lpr, you may be running on an ARM machine."
      echo "Go to ./cake_lpr and uncomment the "cake_lpr_arm8" line in the Makefile."
      echo "Then manually run 'make cake_lpr_arm8'."
      echo "------- build_checkers.sh ---------"
    fi

    cd ..
  else
    echo "Error: ./${checker} does not exist. Try running ./clone_checkers.sh."
    exit
  fi
done