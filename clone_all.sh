#!/bin/sh

echo "Cloning the checker and proof repositories"

for i in $(seq 1 3) ; do
  echo "NOTE: The Lean checker lean-lsr-check is not cloned. Install it separately."
  sleep 1
done

script_dir=$(dirname $0)

$script_dir/clone/clone_checkers.sh
$script_dir/clone/clone_proofs.sh