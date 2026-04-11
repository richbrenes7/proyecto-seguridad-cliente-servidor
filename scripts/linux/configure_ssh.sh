#!/usr/bin/env bash
set -euo pipefail

# Configuracion segura de OpenSSH para laboratorio cliente-servidor.
#
# Objetivos:
# 1) Reducir superficie de ataque del servicio SSH.
# 2) Mantener trazabilidad y control de sesiones.
# 3) Preservar compatibilidad para practicas academicas.
#
# Nota:
# - Por defecto se mantiene PasswordAuthentication en "yes" para permitir
#   simulaciones de intentos fallidos de autenticacion en laboratorio.
# - Si deseas un perfil mas estricto, exporta:
#   ALLOW_PASSWORD_AUTH=no

if [[ $EUID -ne 0 ]]; then
  echo "Este script debe ejecutarse como root o con sudo."
  exit 1
fi

SSHD_CFG="/etc/ssh/sshd_config"
ALLOW_PASSWORD_AUTH="${ALLOW_PASSWORD_AUTH:-yes}"

if [[ ! -f "$SSHD_CFG" ]]; then
  echo "No se encontro $SSHD_CFG"
  exit 1
fi

# Genera respaldo versionado antes de cualquier cambio.
cp "$SSHD_CFG" "${SSHD_CFG}.bak.$(date +%F-%H%M%S)"

# Reemplaza una directiva existente (comentada o no) o la agrega al final.
set_sshd_option() {
  local key="$1"
  local value="$2"

  if grep -Eq "^[#[:space:]]*${key}[[:space:]]+" "$SSHD_CFG"; then
    sed -i -E "s|^[#[:space:]]*${key}[[:space:]]+.*|${key} ${value}|" "$SSHD_CFG"
  else
    echo "${key} ${value}" >> "$SSHD_CFG"
  fi
}

# Endurecimiento recomendado para laboratorio.
set_sshd_option "PermitRootLogin" "no"
set_sshd_option "PasswordAuthentication" "$ALLOW_PASSWORD_AUTH"
set_sshd_option "PubkeyAuthentication" "yes"
set_sshd_option "ChallengeResponseAuthentication" "no"
set_sshd_option "KbdInteractiveAuthentication" "no"
set_sshd_option "UsePAM" "yes"
set_sshd_option "X11Forwarding" "no"
set_sshd_option "PermitEmptyPasswords" "no"
set_sshd_option "MaxAuthTries" "3"
set_sshd_option "LoginGraceTime" "30"
set_sshd_option "ClientAliveInterval" "300"
set_sshd_option "ClientAliveCountMax" "2"
set_sshd_option "AllowTcpForwarding" "no"
set_sshd_option "AllowAgentForwarding" "no"
set_sshd_option "PermitTunnel" "no"
set_sshd_option "MaxSessions" "5"

# Restringe acceso SSH a grupos esperados del laboratorio.
set_sshd_option "AllowGroups" "admins_lab usuarios_lab"

# Nota importante:
# En Ubuntu, modificar /etc/pam.d/common-auth de forma directa puede afectar
# el inicio de sesion local en tty, sudo y su. Para evitar bloquear el acceso
# interactivo del laboratorio, este script no altera PAM automaticamente.
# Si se desea endurecer bloqueo por intentos fallidos, hacerlo con un perfil
# probado para la distribucion y validar acceso local antes de cerrar sesion.
configure_pam_faillock() {
  local pam_system_auth="/etc/pam.d/system-auth"
  local pam_password_auth="/etc/pam.d/password-auth"

  if [[ -f "$pam_system_auth" && -f "$pam_password_auth" ]]; then
    if ! grep -q "pam_faillock.so" "$pam_system_auth"; then
      {
        echo "auth required pam_faillock.so preauth silent audit deny=5 unlock_time=900"
        echo "auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900"
      } >> "$pam_system_auth"
    fi

    if ! grep -q "pam_faillock.so" "$pam_password_auth"; then
      {
        echo "auth required pam_faillock.so preauth silent audit deny=5 unlock_time=900"
        echo "auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900"
      } >> "$pam_password_auth"
    fi
    return
  fi

  echo "[INFO] No se aplicaron cambios PAM automaticos en esta distribucion."
}

configure_pam_faillock

# Valida sintaxis antes de reiniciar para evitar perder acceso remoto.
sshd -t

# Reinicia el servicio usando el nombre disponible segun distribucion.
if systemctl list-unit-files | grep -q '^ssh\.service'; then
  systemctl restart ssh
  systemctl enable ssh >/dev/null 2>&1 || true
elif systemctl list-unit-files | grep -q '^sshd\.service'; then
  systemctl restart sshd
  systemctl enable sshd >/dev/null 2>&1 || true
else
  echo "[WARN] No se encontro servicio ssh/sshd para reiniciar automaticamente."
fi

echo "[OK] Configuracion SSH aplicada correctamente."
