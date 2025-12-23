#!/bin/bash

# ¡Necesitas ser root!
if [ "$EUID" -ne 0 ]
then
  echo "Este script debe ejecutarse como root o con sudo"
  exit 1
fi


cd "$(dirname "{BASH_SOURCE[0]}")"

bash ./apt/init.sh
bash ./firewall/init.sh
bash ./config/init.sh
bash ./monitoring/add_crontab.sh