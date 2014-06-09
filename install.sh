#!/usr/bin/env bash

red="\x1B[31m"
green="\x1B[32m"
reset="\x1B[0m"

echo -e "Linking local ~/. files to custom dotfiles...\r"

for source_file in _*; do
  source_path="$PWD/$source_file"
  destination_path=~/.${source_file:1}

  if [ ! -e $destination_path ]; then
    echo -e "${green}Linking $source_path to $destination_path${reset}"
    ln -nfs $source_path $destination_path
  else
    echo -e "${red}Skipping $source_path as it's already linked${reset}"
  fi
done

echo -e "Done!"
