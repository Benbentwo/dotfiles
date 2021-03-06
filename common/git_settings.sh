#!/usr/bin/env bash

echo " --------------------------- Configuring git --------------------------- "
git config --global core.excludesfile ~/.gitignore_global
git config --global user.name "Benjamin Smith"
git config --global user.email "ben.smith.developer@gmail.com"
git config --global core.editor "vim"
git config --global core.filemode true
git config --global color.ui true
git config --global push.default simple

git config --global gitreview.scheme=ssh
git config --global gitreview.username=Benbentwo

git config --global alias.br "! git for-each-ref --sort='authordate' --format='%(refname)%09%(authordate)' refs/heads | sed -e 's-refs/heads/--' | tail"


#### MAC
#if [[ "$OSTYPE" == "darwin"* ]]; then
#git config --global user.signingkey 44467E0C458A6875C0C03BDBEF76DF7495A88C1E
#git config --global gpg.program gpg
#fi

# check
echo "Git settings:"
git config --list | tee
echo " ------------------------- DONE Configuring git ------------------------ "
