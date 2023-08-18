# add config_r.sh to be sourced if 
# it's not already present
if ! [ -e "$HOME/.bashrc.d/config_r.sh" ]; then
  if ! [ -d "$HOME/.bashrc.d" ]; then mkdir -p "$HOME/.bashrc.d"; fi
  cp "/template_script/all/config_r.sh" "$HOME/.bashrc.d/" || exit 1
  chmod 755 "$HOME/.bashrc.d/config_r.sh"
fi
