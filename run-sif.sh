#!/usr/bin/env bash
comp_dir=$(ls .. | grep -E "^Comp")
if [ -z "$comp_dir" ]; then
  scripts_dir=./scripts
else
  scripts_dir=../"$comp_dir"/scripts
fi
"$scripts_dir"/apptainer/run/run_apptainer.sh bash
