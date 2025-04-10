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

echo -e "${C_SUCCESS}"
echo "***************************************************************"
echo "BEGIN DOTFILE SYMLINKING!"
echo "***************************************************************"
echo -e "${C_RESET}"

echo -e "${C_INFO}"
echo "*********************************"
echo "Linking local '\$HOME/.'          "
echo "files to custom _dotfiles...     "
echo "*********************************"
echo -e "${C_RESET}"

# ./: $HOME/_*
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

## ./config - $HOME/.config/**/*
for src_dir_file in config/**/*; do
  f="$(basename "$src_dir_file")"
  d="$(basename "$(dirname "$src_dir_file")")"
  src_path="$PWD/$src_dir_file"
  dest_dir="$HOME/.config/$d"

  if [ ! -e "$dest_dir" ]; then
    mkdir -p "$dest_dir"
  fi

  dest_path="${dest_dir}/${f}"

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

## ./_linting - $HOME/_*
# for src_file in linting/_*; do
#   f="$(basename -- "$src_file")"
#   src_path="$PWD/$src_file"
#   dest_path="$HOME"/.${f:1}

#   if [ ! -e "$dest_path" ]; then
#     link_file "$src_path" "$dest_path"
#   else
#     if [ "$1" == "-d" ]; then
#       if [ -h "$dest_path" ]; then
#         skip_file "$dest_path" $err_linked
#       else
#         backup_file "$dest_path"
#         link_file "$src_path" "$dest_path"
#       fi
#     else
#       skip_file "$dest_path" $err_exists
#     fi
#   fi
# done

echo -e "${C_INFO}"
echo "*********************************"
echo "Creating missing '\$HOME' dirs   "
echo "for git, ssh, vim, etc.          "
echo "*********************************"
echo -e "${C_RESET}"

## GIT
# make .gitconfig.d dir if nonexistent
if [ ! -d "$HOME"/.gitconfig.d ]; then
  mkdir "$HOME"/.gitconfig.d
fi
# grab git-completion.bash if nonexistent
if [ ! -f "$HOME"/.git-completion.bash ]; then
  wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
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

## VIM
# make .vim directory if nonexisting
# add custom color theme
if [ ! -d "$HOME"/.vim ]; then
  mkdir -p "$HOME"/.vim/colors
  cd "$HOME"/.vim/colors || exit
  wget https://raw.githubusercontent.com/sjl/badwolf/master/colors/badwolf.vim
fi

echo -e "${C_SUCCESS}"
echo "***************************************************************"
echo "DONE CONFIG SYMLINKING!"
echo "***************************************************************"
echo -e "${C_RESET}"
