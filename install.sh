#!/usr/bin/env bash

# color variables
C_FAILURE="\x1B[31m"
C_SUCCESS="\x1B[32m"
C_INFO="\x1B[33m"
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

echo -e "${C_INFO}"
echo "*****************************************************************"
echo "Linking local '$HOME/.' files to custom _dotfiles..."
echo "*****************************************************************"
echo -e "${C_RESET}"

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

## LINTING
for src_file in linting/_*; do
  f="$(basename -- "$src_file")"
  src_path="$PWD/$src_file"
  dest_path="$HOME"/.${f:1}.json

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

echo -e "${C_INFO}"
echo "*****************************************************************"
echo "Creating missing '$HOME' dirs for git, ssh, vim, etc."
echo "*****************************************************************"
echo -e "${C_RESET}"

## GIT
# make .gitconfig.d dir if nonexistent
if [ ! -d "$HOME"/.gitconfig.d ]; then
  mkdir "$HOME"/.gitconfig.d
fi
# grab git-prompt.sh if nonexistent
if [ ! -f "$HOME"/.git-prompt.sh ]; then
  cd "$HOME" || exit
  wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
  mv git-prompt.sh .git-prompt.sh
fi

## SSH
# make ssh dir if nonexistent
# then link custom ssh config
if [ ! -d "$HOME"/.ssh ]; then
  mkdir -p "$HOME"/.ssh
fi
if [ ! -f "$HOME"/.ssh/config ]; then
  ln -s "$PWD"/ssh/_config "$HOME"/.ssh/config
fi

## STARSHIP
# make starship dir if nonexistent
if [ -d .starship ]; then
  if [ ! -d "$HOME"/.starship ]; then
    mkdir -p "$HOME"/.starship
  fi
fi
if [ ! -f "$HOME"/.starship/config.toml ]; then
  ln -s "$PWD"/starship/_config.toml "$HOME"/.starship/config.toml
fi

## VIM
# make .vim directory if nonexisting
# add custom color theme
if [ ! -d "$HOME"/.vim ]; then
  mkdir -p "$HOME"/.vim/colors
  cd "$HOME"/.vim/colors || exit
  wget https://raw.githubusercontent.com/sjl/badwolf/master/colors/badwolf.vim
fi

echo -e "${C_INFO}"
echo "*****************************************************************"
echo "Done!"
echo "*****************************************************************"
echo -e "${C_RESET}"
