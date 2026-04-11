#!/usr/bin/env bash
set -euo pipefail

# Crea grupos y usuarios base para pruebas de roles
if [[ $EUID -ne 0 ]]; then
  echo "Ejecutar como root o con sudo"
  exit 1
fi

groupadd -f admins_lab
groupadd -f usuarios_lab

id adminlab >/dev/null 2>&1 || useradd -m -s /bin/bash -G admins_lab,sudo adminlab
id usuario1lab >/dev/null 2>&1 || useradd -m -s /bin/bash -G usuarios_lab usuario1lab

echo "Asignar contrasenas manualmente con: passwd adminlab y passwd usuario1lab"
echo "[OK] Usuarios y grupos base creados"
