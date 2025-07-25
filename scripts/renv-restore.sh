#!/usr/bin/env bash

# strict mode
set -o errexit
set -o nounset
set -o pipefail

# only split on newline and tab
IFS=$'\n\t'

# 1. Where the user ran this script from:
INVOKE_DIR="$PWD"

# 2. Where this script file lives (in case you ever need it)
SCRIPT_DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd)"

# (Optional) If you need to install renv in a project one‑level up from the script:
# PROJECT_ROOT="$SCRIPT_DIR/.."

restore_renv() {
  echo "🔄  Found renv.lock – restoring with renv…"
  # …but from here on *we stick* in $INVOKE_DIR
  cd "$INVOKE_DIR/.." || exit 1
  echo "⚙️  Checking for renv…"
  Rscript -e '
    if (!requireNamespace("renv", quietly=TRUE))
      install.packages("renv", repos="https://cloud.r-project.org")
  '
  cd "$INVOKE_DIR" || exit 1

  echo "⚙️  Checking for gitcreds…"
  Rscript -e '
    if (!requireNamespace("gitcreds", quietly=TRUE))
      renv::install("gitcreds")
  '

  echo "🔗  Installing UtilsProjrMR…"
  Rscript -e 'renv::install("MiguelRodo/UtilsProjrMR")'

  echo "🔄  Updating & restoring project via UtilsProjrMR…"
  Rscript -e 'UtilsProjrMR::projr_renv_restore_and_update()'

  echo "✅  All done from: $INVOKE_DIR"
}

restore_pak_desc() {
  echo "🔄  Found DESCRIPTION – installing via pak…"
  Rscript -e '
    if (!requireNamespace("pak", quietly=TRUE))
      install.packages("pak", repos="https://cloud.r-project.org");
    # install deps of the local package, then the package itself
    pak::local_install_dev_deps()
  ' || exit 1
}

main() {
  # 1. renv-based restore
  if [ -f renv.lock ]; then
    restore_renv
  else
    echo "ℹ️  No renv.lock in $INVOKE_DIR"
    if [ -f DESCRIPTION ]; then
      restore_pak_desc
    else
      echo "❌  No DESCRIPTION either – cannot determine what to install."
      exit 1
    fi
  fi
}

main "$@"
