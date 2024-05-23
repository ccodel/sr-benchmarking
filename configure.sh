#!/bin/sh

script_dir=$(dirname $0)

for dir in build clean clone collate experiments run ; do
  for sh in ./${dir}/*.sh; do
    chmod +x ${sh}
  done
done

for sh in build check clean clone collate label  ; do
  chmod +x ${script_dir}/${sh}_all.sh
done

for sh in all label_quick run_experiments ; do
  chmod +x ${script_dir}/${sh}.sh
done