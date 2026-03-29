#!/usr/bin/env bash
set -euo pipefail

# Respaldo y restauracion basica de directorio critico
# Uso:
#   ./backup.sh backup
#   ./backup.sh restore <archivo-tar.gz>

if [[ $EUID -ne 0 ]]; then
  echo "Ejecutar como root o con sudo"
  exit 1
fi

SOURCE_DIR="/srv/datos_compartidos"
BACKUP_DIR="/var/backups/lab"
mkdir -p "$BACKUP_DIR"

ACTION="${1:-backup}"

if [[ "$ACTION" == "backup" ]]; then
  TS=$(date +%F-%H%M%S)
  FILE="$BACKUP_DIR/datos_compartidos-$TS.tar.gz"
  tar -czf "$FILE" -C / srv/datos_compartidos
  echo "[OK] Respaldo generado: $FILE"
elif [[ "$ACTION" == "restore" ]]; then
  FILE="${2:-}"
  if [[ -z "$FILE" || ! -f "$FILE" ]]; then
    echo "Indica el archivo de respaldo existente"
    exit 1
  fi
  tar -xzf "$FILE" -C /
  echo "[OK] Restauracion completada desde: $FILE"
else
  echo "Accion no valida. Usa backup o restore"
  exit 1
fi
