#!/bin/bash

ruta_script="/root/stats.sh"
schedule="* * * * 10"

cd "$(dirname "{BASH_SOURCE[0]}")"

cp ./stats.sh $ruta_script

(crontab -l 2>/dev/null; echo "$schedule $ruta_script") | crontab -