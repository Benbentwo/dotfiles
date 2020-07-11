#!/usr/bin/env bash
# Init script for a main machine (Mac)

echo " --------------------------- INIT --------------------------- "
# 1) dotfiles
for f in $(ls -d $(pwd)/dotfiles/.?* | grep -v "^/.$" | grep -v "/..$"); do
    ln -sf $f ~/
done

# 2) os-specific
for f in $(ls ./mac/); do
    bash ./mac/"$f"
done

# 3) commons
bash ./common/packages_pip.sh
bash ./common/setup_zsh.sh
bash ./common/git_settings.sh

echo "--------------------------- Copying Plist Configs"
for plist in $(ls ./mac/00_plists/*.plist); do
    echo "$plist"
    cp $plist ~/Library/Preferences/
done
echo "--------------------------- Restarting Services"
    bash ./mac/00_plists/restart.sh
echo " --------------------------- DONE --------------------------- "
