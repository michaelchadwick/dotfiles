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
  mv $1 ${1}.bak
  echo -e "${C_MISC}Backed up $1 to ${1}.bak${C_RESET}"
}
function link_file() {
  ln -nfs $1 $2
  echo -e "${C_SUCCESS}Linked $2 to $1${C_RESET}"
}
function skip_file() {
  echo -e "${C_FAILURE}Skipped $1: $2${C_RESET}"
}

echo -e "Linking local ~/. files to custom _dotfiles...\r"

for src_file in _*; do
  src_path="$PWD/$src_file"
  dest_path=$HOME/.${src_file:1}

  if [ ! -e $dest_path ]; then
    link_file $src_path $dest_path
  else
    if [ "$1" == "-d" ]; then
      if [ -h $dest_path ]; then
        skip_file $dest_path $err_linked
      else
        backup_file $dest_path
        link_file $src_path $dest_path
      fi
    else
      skip_file $dest_path $err_exists
    fi
  fi
done

echo -e "Done!"
