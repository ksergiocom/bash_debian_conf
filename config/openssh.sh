#!/bin/bash

PUERTO=20
SSH_CONFIG="/etc/ssh/sshd_config"

# Reemplazar Port (comentado o no)
sed -i \
  -e "s/^[[:space:]]*#\?[[:space:]]*Port[[:space:]].*/Port $PUERTO/" \
  "$SSH_CONFIG"

# Reemplazar PermitRootLogin (comentado o no)
sed -i \
  -e "s/^[[:space:]]*#\?[[:space:]]*PermitRootLogin[[:space:]].*/PermitRootLogin no/" \
  "$SSH_CONFIG"

# Si no existen, agregarlos al final
grep -qE '^[[:space:]]*Port[[:space:]]+' "$SSH_CONFIG" || echo "Port $PUERTO" >> "$SSH_CONFIG"
grep -qE '^[[:space:]]*PermitRootLogin[[:space:]]+' "$SSH_CONFIG" || echo "PermitRootLogin no" >> "$SSH_CONFIG"

systemctl restart sshd
