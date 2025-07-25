#!/usr/bin/env bash

# Strict mode (split across lines for compatibility)
set -o errexit   # same as -e
set -o nounset   # same as -u
set -o pipefail

# only split on newline and tab
IFS=$'\n\t'

# resolve the directory
WORKING_DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd)"

# change to project root (one level up)
cd "$WORKING_DIR/.." || exit 1

echo "⚙️  Checking for renv…"
Rscript -e 'if (!requireNamespace("renv", quietly=TRUE)) install.packages("renv", repos="https://cloud.r-project.org")'

# back to script dir if you need it later
cd "$WORKING_DIR" || exit 1

echo "⚙️  Checking for gitcreds…"
Rscript -e 'if (!requireNamespace("gitcreds", quietly=TRUE)) renv::install("gitcreds")'

echo "🔗  Installing UtilsProjrMR…"
Rscript -e 'renv::install("MiguelRodo/UtilsProjrMR")'

echo "🔄  Updating & restoring project via UtilsProjrMR…"
Rscript -e 'UtilsProjrMR::projr_renv_restore_and_update()'

echo "✅  All done!"
