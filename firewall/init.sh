#!/bin/bash

# Permitir SSH en el nuevo puerto
ufw allow 4242/tcp

# Políticas por defecto
ufw default deny incoming
ufw default allow outgoing

# Habilitar UFW sin pedir confirmación
ufw --force enable
