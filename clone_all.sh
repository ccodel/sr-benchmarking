#!/bin/sh

echo "Cloning the checker and proof repositories"
echo "NOTE: The Lean checker lean-lsr-check is not cloned. Install it separately."
sleep 1
echo "NOTE: The Lean checker lean-lsr-check is not cloned. Install it separately."
sleep 1
echo "NOTE: The Lean checker lean-lsr-check is not cloned. Install it separately."

script_dir=$(dirname $0)

$script_dir/clone/clone_checkers.sh
$script_dir/clone/clone_proofs.sh