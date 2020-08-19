#!/usr/bin/env bash
# Init script for a secondary machine (centos)

echo " --------------------------- INIT --------------------------- "
# 1) dotfiles
for f in $(ls -d $(pwd)/dotfiles/.?* | grep -v "^/.$" | grep -v "/..$"); do
    ln -sf $f ~/
done

# 2) os-specific
for f in $(ls ./centos/); do
    bash ./centos/"$f"
done

# 3) commons
bash ./common/packages_pip.sh
bash ./common/ssh_access.sh
bash ./common/setup_zsh.sh
bash ./common/git_settings.sh

echo " --------------------------- DONE --------------------------- "
