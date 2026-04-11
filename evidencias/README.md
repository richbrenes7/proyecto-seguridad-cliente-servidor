# Evidencias del Proyecto

## Objetivo
Almacenar capturas, extractos de logs, comandos ejecutados y resultados de simulaciones.

## Estructura sugerida
1. S1-intentos-fallidos-autenticacion/
2. S2-acceso-segun-roles/
3. S3-comunicacion-segura/
4. S4-respaldo-y-recuperacion/
5. S5-monitoreo-y-auditoria/
6. S6-respuesta-incidente/
7. 00-bitacora-configuracion/

## Recomendaciones
1. Incluir fecha, hora y maquina origen en cada evidencia.
2. Evitar exponer credenciales reales en capturas.
3. Mantener nomenclatura consistente para facilitar defensa academica.

## Carpeta Recomendada para lo que ya corregimos
Usa `evidencias/00-bitacora-configuracion/` para documentar ajustes del laboratorio que no pertenecen a una sola simulacion.

Contenido sugerido:
1. `01-hyperv-y-arranque-vms.md`
2. `02-instalacion-clientes-windows10.md`
3. `03-recuperacion-acceso-ubuntu.md`
4. `04-validacion-ssh-y-grupos.md`

## Paso a Paso de Ajustes Realizados

### 1. Arranque y nombres de VMs en Hyper-V
Objetivo: levantar `srv-linux-seg`, `cli-01` y `cli-02` con nombres consistentes.

Comandos usados:
```powershell
Start-VM -Name "srv-linux-seg"
Start-VM -Name "cli-01"
Start-VM -Name "cli-02"
```

Notas para documentar:
1. El nombre correcto del servidor es `srv-linux-seg`.
2. Se verifico que el host usa Hyper-V con vSwitch interno del laboratorio.
3. Se dejo evidencia de errores de permisos cuando la sesion no tenia privilegios efectivos de Hyper-V.

### 2. Montaje correcto de ISO para clientes Windows
Objetivo: corregir fallo de arranque por ISO inexistente o arquitectura incorrecta.

Hallazgos:
1. La ruta inicial a la ISO no existia.
2. Una ISO ARM64 no era adecuada para las VMs cliente en Hyper-V.
3. Se estandarizo el uso de Windows 10 para clientes.

Comandos usados:
```powershell
$iso = "D:\Data\ClienteServidor\proyecto-seguridad-cliente-servidor\.local\isos\windows10.iso"
Test-Path $iso

$vms = @("cli-01","cli-02")
foreach ($vm in $vms) {
  Stop-VM -Name $vm -TurnOff -Force -ErrorAction SilentlyContinue
  Get-VMDvdDrive -VMName $vm -ErrorAction SilentlyContinue | Remove-VMDvdDrive -ErrorAction SilentlyContinue
  Add-VMDvdDrive -VMName $vm -Path $iso | Out-Null
  Set-VMFirmware -VMName $vm -EnableSecureBoot On -SecureBootTemplate MicrosoftWindows
  $dvd = Get-VMDvdDrive -VMName $vm
  Set-VMFirmware -VMName $vm -FirstBootDevice $dvd
  Start-VM -Name $vm | Out-Null
}
```

Evidencia sugerida:
1. Captura del error inicial con ISO inexistente.
2. Captura del arranque correcto tras montar `windows10.iso`.

### 3. Recuperacion de acceso al servidor Ubuntu
Objetivo: restablecer acceso cuando la contrasena no funcionaba en `tty1`.

Metodo aplicado:
1. Arranque por GRUB con `rw init=/bin/bash`.
2. Remontaje de `/` en modo escritura.
3. Reseteo de contrasena del usuario correcto.
4. Verificacion con `su - usuario`.

Comandos usados:
```bash
mount -o remount,rw /
ls /home
passwd adminlab
passwd -u adminlab
passwd -S adminlab
su - adminlab
sync
reboot -f
```

Hallazgo importante:
1. La autenticacion local podia verse afectada por cambios PAM.
2. Se confirmo que `adminlab` y `usuario1lab` eran usuarios validos.

### 4. Validacion de SSH, grupos y causa del bloqueo
Objetivo: demostrar acceso SSH correcto y explicar el bloqueo observado.

Hallazgo principal:
1. El bloqueo no fue del grupo `admins_lab`.
2. Se intento autenticar por SSH usando `admins_lab` como si fuera usuario.
3. El usuario correcto para acceso es `adminlab`.

Comandos usados en servidor:
```bash
id adminlab
ss -tulpn | grep :22
grep -n '^AllowGroups' /etc/ssh/sshd_config
systemctl status ssh --no-pager
sudo ufw status
sudo faillock --user adminlab
sudo faillock --user adminlab --reset
```

Comando correcto desde cliente:
```bash
ssh adminlab@192.168.1.61
```

Comando incorrecto que explica el incidente:
```bash
ssh admins_lab@192.168.1.61
```

Evidencia sugerida:
1. Log con `invalid user admins_lab`.
2. Log con `Accepted password for adminlab`.
3. Captura de `id adminlab` mostrando pertenencia a `admins_lab`.

## Paso a Paso de Simulaciones Pendientes

### S2. Acceso Segun Roles
```bash
sudo mkdir -p /srv/datos_compartidos
sudo chown root:admins_lab /srv/datos_compartidos
sudo chmod 2770 /srv/datos_compartidos
ls -ld /srv/datos_compartidos
id adminlab
id usuario1lab
su - adminlab
cd /srv/datos_compartidos
touch prueba_admin.txt
exit
su - usuario1lab
cd /srv/datos_compartidos
touch prueba_usuario.txt
```

Resultado esperado:
1. `adminlab` accede y crea archivo.
2. `usuario1lab` recibe `Permission denied`.

### S3. Comunicacion Segura
```bash
ssh adminlab@192.168.1.61
```

En servidor:
```bash
ss -tulpn | grep :22
systemctl status ssh --no-pager
```

### S4. Respaldo y Recuperacion
Crear archivo de prueba:
```bash
echo "archivo original laboratorio" | sudo tee /srv/datos_compartidos/archivo_prueba.txt
sha256sum /srv/datos_compartidos/archivo_prueba.txt
```

Ejecutar respaldo:
```bash
cd ~/lab-scripts
sudo bash backup.sh backup
sudo ls -lh /var/backups/lab
```

Alterar archivo:
```bash
echo "contenido alterado" | sudo tee /srv/datos_compartidos/archivo_prueba.txt
sha256sum /srv/datos_compartidos/archivo_prueba.txt
```

Restaurar:
```bash
sudo bash backup.sh restore /var/backups/lab/NOMBRE_DEL_ARCHIVO.tar.gz
sha256sum /srv/datos_compartidos/archivo_prueba.txt
```

### S5. Monitoreo y Auditoria
```bash
sudo tail -n 50 /var/log/auth.log
sudo journalctl -u ssh --no-pager | tail -n 50
sudo journalctl --no-pager | grep -Ei "sudo|sshd|authentication|failed"
sudo ls /root
```

### S6. Respuesta ante Incidente
Escenario sugerido:
1. Generar varios intentos fallidos por SSH.
2. Confirmar el evento en logs.
3. Desbloquear usuario y documentar recuperacion.

Comandos:
```bash
sudo faillock --user adminlab
sudo faillock --user adminlab --reset
sudo tail -n 50 /var/log/auth.log
```
