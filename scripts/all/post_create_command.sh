#!/usr/bin/env bash
# ensure that `$HOME/.bashrc.d` files are sourced
dir_scripts="/template_script/script" 
"$dir_scripts/all/setup_bashrc_d.sh" || exit 1

# add config_r.sh to be sourced if 
# it's not already present
if ! [ -e "$HOME/.bashrc.d/config_r.sh" ]; then
  if ! [ -d "$HOME/.bashrc.d" ]; then mkdir -p "$HOME/.bashrc.d"; fi
  cp "$dir_scripts/all/config_r.sh" "$HOME/.bashrc.d/" || exit 1
  chmod 755 "$HOME/.bashrc.d/config_r.sh"
fi

"$dir_scripts/ubuntu/install_apptainer.sh" || exit 1
"$dir_scripts/ubuntu/install_gh.sh" || exit 1
"$dir_scripts/apptainer/ubuntu/R/add_r_libs-select.sh" || exit 1

if [ -n "$(env | grep -E "^GITPOD")" ]; then
  # install tools to run and download containers
  sudo "$dir_scripts/all/install_r.sh"
fi

