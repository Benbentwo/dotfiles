#!/usr/bin/env bash

if ! command -v pip 2>/dev/null; then
    curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
    python get-pip.py
    rm -f get-pip.py
fi
pip install --upgrade pip

pip install ipython
pip install virtualenv
pip install virtualenvwrapper
pip install aws-profile
#pip install git-review  # Gerrit
