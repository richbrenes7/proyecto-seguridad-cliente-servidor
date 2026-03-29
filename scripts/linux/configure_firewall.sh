#!/usr/bin/env bash
set -euo pipefail

# Firewall local con UFW
if [[ $EUID -ne 0 ]]; then
  echo "Ejecutar como root o con sudo"
  exit 1
fi

ufw --force reset
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp comment 'SSH seguro'
ufw allow 443/tcp comment 'HTTPS de pruebas opcional'
ufw --force enable
ufw status verbose

echo "[OK] Firewall configurado"
