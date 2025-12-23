#!/bin/bash

# Solo actualizamos una vez desde aquí
apt-get update -y

# Cambiar la ruta relativa para poder invocar otros scripts correctamente
cd "$(dirname "${BASH_SOURCE[0]}")"

# Instalaciones especiales
bash ./custom/dbeaver.sh
bash ./custom/vscodium.sh
bash ./custom/docker.sh
bash ./custom/github-desktop.sh

# Actualizar con los custom
apt-get update -y

apt-get install -y \
	vim \
	ufw \
	fastfetch \
	openssh-server \
	codium \
	github-desktop \
	docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
