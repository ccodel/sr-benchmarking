#!/bin/sh

# Clones the proof checkers.
# If any of the following directories already exist at project root level:
#    ./drat-trim/
#    ./dpr-trim/
#    ./cake_lpr/
#    ./dsr-trim/
#    ./ppr2drat/
# then instead it will `git pull`.

for checker in drat-trim dpr-trim ppr2drat ; do
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
