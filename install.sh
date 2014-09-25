#!/usr/bin/env bash

# variables
failure="\x1B[31m"
success="\x1B[32m"
misc="\x1B[34m"
reset="\x1B[0m"

err_linked="ALREADY-LINKED"
err_exists="ALREADY-EXISTS"

# methods
function backup_file() {
  mv $1 ${1}.bak
  echo -e "${misc}Backed up $1 to ${1}.bak${reset}"
}
function link_file() {
  ln -nfs $1 $2
  echo -e "${success}Linked $1 to $2${reset}"
}
function skip_file() {
  echo -e "${failure}Skipped $1: $2${reset}"
}

echo -e "Linking local ~/. files to custom dotfiles...\r"

for src_file in _*; do
  src_path="$PWD/$src_file"
  dest_path=~/.${src_file:1}
  dest_bak_path=~/.${src_file:1}.bak

  if [ ! -e $dest_path ]; then
    link_file $src_path $dest_path
  else
    if [ "$1" == "-d" ]; then
      if [ -h $dest_path ]; then
        skip_file $src_path $err_linked
      else
        backup_file $dest_path
        link_file $src_path $dest_path
      fi
    else
      skip_file $src_path $err_exists
    fi
  fi
done

echo -e "Done!"
