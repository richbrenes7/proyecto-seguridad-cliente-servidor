#!/usr/bin/env bash
set -euo pipefail

# Hardening basico orientado a laboratorio academico
if [[ $EUID -ne 0 ]]; then
  echo "Ejecutar como root o con sudo"
  exit 1
fi

# Permisos por defecto mas restrictivos
if grep -q '^UMASK' /etc/login.defs; then
  sed -i 's/^UMASK.*/UMASK 027/' /etc/login.defs
else
  echo 'UMASK 027' >> /etc/login.defs
fi

# Ajustes sysctl minimos
cat >/etc/sysctl.d/99-lab-hardening.conf <<'EOF'
net.ipv4.conf.all.rp_filter = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1
kernel.kptr_restrict = 2
kernel.dmesg_restrict = 1
EOF

sysctl --system

# Carpeta compartida de ejemplo con control de acceso
mkdir -p /srv/datos_compartidos
chown root:admins_lab /srv/datos_compartidos
chmod 2770 /srv/datos_compartidos

echo "[OK] Hardening basico aplicado"
