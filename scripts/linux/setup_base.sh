#!/usr/bin/env bash
set -euo pipefail

# Preparacion base del servidor Linux para laboratorio de seguridad
if [[ $EUID -ne 0 ]]; then
  echo "Ejecutar como root o con sudo"
  exit 1
fi

apt-get update
apt-get install -y openssh-server ufw rsyslog auditd fail2ban curl ca-certificates

systemctl enable --now ssh
systemctl enable --now rsyslog
systemctl enable --now auditd
systemctl enable --now fail2ban

timedatectl set-timezone UTC || true

echo "[OK] Configuracion base completada"
