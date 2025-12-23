#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}")

# .bashrc, .vimrc y acii
cp -r ./files/* $HOME/

bash ./openssh.sh
bash ./passwords.sh
bash ./sudo.sh