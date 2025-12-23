#!/bin/bash

USUARIOS=(ksergio)
GRUPOS=(sudo)

for GRUPO in "${GRUPOS[@]}"; do
  if getent group "$GRUPO" > /dev/null
  then
    echo "Grupo $GRUPO ya existe"
  else
    echo "Creando grupo $GRUPO..."
    groupadd "$GRUPO"
  fi
done

for USUARIO in "${USUARIOS[@]}"
do
  if id "$USUARIO" &>/dev/null
  then
    echo "El usuario $USUARIO ya existe"
  else
    echo "Creando usuario $USUARIO..."

    adduser \
      --disabled-password \
      --gecos "" \
      --home "/home/$USUARIO" \
      --shell "/bin/bash" \
      "$USUARIO"
  fi

  usermod -aG "$(IFS=,; echo "${GRUPOS[*]}")" "$USUARIO"
done
