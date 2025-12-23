#!/bin/bash

wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb

apt-get install ./dbeaver-ce_latest_amd64.deb

rm ./dbeaver-ce_latest_amd64.deb
