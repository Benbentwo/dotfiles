#!/usr/bin/env bash

for x in $(brew cask list); do
    brew cask uninstall --force $x
    brew cask zap $x
done