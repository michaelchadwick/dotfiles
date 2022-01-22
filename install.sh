#!/usr/bin/env bash

# color variables
C_FAILURE="\x1B[31m"
C_SUCCESS="\x1B[32m"
C_MISC="\x1B[34m"
C_RESET="\x1B[0m"

err_linked="ALREADY-LINKED"
err_exists="ALREADY-EXISTS"

# methods
function backup_file() {
  mv "$1" "${1}".bak
  echo -e "${C_MISC}Backed up $1 to ${1}.bak${C_RESET}"
}
function link_file() {
  ln -nfs "$1" "$2"
  echo -e "${C_SUCCESS}Linked $2 to $1${C_RESET}"
}
function skip_file() {
  echo -e "${C_FAILURE}Skipped $1: $2${C_RESET}"
}

echo "Linking local ~/. files to custom _dotfiles..."
echo "**********************************************"

# loop through template config and symlink to $HOME
for src_file in _*; do
  src_path="$PWD/$src_file"
  dest_path="$HOME"/.${src_file:1}

  if [ ! -e "$dest_path" ]; then
    link_file "$src_path" "$dest_path"
  else
    if [ "$1" == "-d" ]; then
      if [ -h "$dest_path" ]; then
        skip_file "$dest_path" $err_linked
      else
        backup_file "$dest_path"
        link_file "$src_path" "$dest_path"
      fi
    else
      skip_file "$dest_path" $err_exists
    fi
  fi
done

if [ ! -d "$HOME"/.gitconfig.d ]; then
  mkdir "$HOME"/.gitconfig.d
fi

# set up vim color theme
if [ ! -d "$HOME"/.vim ]; then
  mkdir -p "$HOME"/.vim/colors
  cd "$HOME"/.vim/colors || exit
  wget https://raw.githubusercontent.com/sjl/badwolf/master/colors/badwolf.vim
fi

# make ssh dir if doesn't exist
if [ ! -d "$HOME"/.ssh ]; then
  mkdir -p "$HOME"/.ssh
fi

# then link custom ssh config
if [ ! -f "$HOME"/.ssh/config ]; then
  ln -s "$PWD"/ssh/_config "$HOME"/.ssh/config
fi

# make starship dir if doesn't exist
if [ -d .starship ]; then
  if [ ! -d "$HOME"/.starship ]; then
    mkdir -p "$HOME"/.starship
  fi
fi

# then link custom starship.rs config
if [ ! -f "$HOME"/.starship/config.toml ]; then
  ln -s "$PWD"/starship/_config.toml "$HOME"/.starship/config.toml
fi

echo "*********************************************"
echo -e "Done!"
