#!/bin/bash

# Source - https://stackoverflow.com/a
# Posted by Danny Beckett, modified by community. See post 'Timeline' for change history
# Retrieved 2025-12-23, License - CC BY-SA 4.0

wget -qO - https://mirror.mwt.me/shiftkey-desktop/gpgkey | gpg --dearmor | tee /usr/share/keyrings/mwt-desktop.gpg > /dev/null
sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/mwt-desktop.gpg] https://mirror.mwt.me/shiftkey-desktop/deb/ any main" > /etc/apt/sources.list.d/mwt-desktop.list'
