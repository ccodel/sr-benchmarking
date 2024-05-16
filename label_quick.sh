#!/bin/sh

# Labels smaller PR and SR files

script_dir=$(dirname $0)
$script_dir/run/run_labeler_quick.sh dpr-trim dpr-trim pr
$script_dir/run/run_labeler_quick.sh dsr-trim dsr-trim sr