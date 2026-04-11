# Scripts Windows para Pruebas del Laboratorio

## Objetivo
Apoyar simulaciones de gestion de usuarios, acceso por roles y recoleccion de evidencia desde cliente Windows.

## Requisitos
1. Ejecutar PowerShell como Administrador para operaciones de cuentas locales.
2. Permitir ejecucion de scripts segun politica local.

## Script incluido
1. usuarios_y_pruebas.ps1
2. launch_hyperv_lab.ps1

## Uso sugerido
1. Ejecutar launch_hyperv_lab.ps1 como Administrador para crear vSwitch y VMs base en Hyper-V.
1. Guardar ISOs en una carpeta local fuera de control de versiones: .local/isos (raiz del proyecto).
1. Para clientes Windows, guardar la ISO como .local/isos/windows10.iso (o pasar -ClientIsoPath).
1. Crear usuarios locales de laboratorio.
2. Probar acceso a recurso compartido del servidor.
3. Generar evidencia de permisos y errores de acceso.
4. El nombre por defecto de la VM servidor es `srv-linux-seg`.

## Ejemplo de lanzamiento
```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
.\launch_hyperv_lab.ps1 -ServerIsoPath "..\..\.local\isos\ubuntu-22.04.5-live-server-amd64.iso" -ClientIsoPath "..\..\.local\isos\windows10.iso" -StartVMs
```

## Convencion de ISOs locales
1. Servidor Linux: .local/isos/ubuntu-22.04.5-live-server-amd64.iso
2. Cliente Windows: .local/isos/windows10.iso

## Descarga de ISO Windows (opcional desde script)
1. Si windows10.iso no existe, puedes pasar -ClientIsoUrl para que el script la descargue.
2. Si no pasas URL, el script mostrara y abrira la pagina oficial de descarga de Windows 10.
3. Si deseas validar integridad, pasa -ClientIsoSha256 con el SHA256 esperado.

Ejemplo:
```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
.\launch_hyperv_lab.ps1 -ClientIsoUrl "https://<URL-DIRECTA-VALIDA>/windows10.iso" -StartVMs
```

Ejemplo con hash:
```powershell
.\launch_hyperv_lab.ps1 -ClientIsoPath ".local\isos\windows10.iso" -ClientIsoSha256 "<SHA256_ESPERADO>" -StartVMs
```

## Descarga de ISO Ubuntu a carpeta local del proyecto
```powershell
$destDir = "..\..\.local\isos"
$isoUrl  = "https://releases.ubuntu.com/22.04.5/ubuntu-22.04.5-live-server-amd64.iso"
$isoPath = Join-Path $destDir "ubuntu-22.04.5-live-server-amd64.iso"

New-Item -ItemType Directory -Path $destDir -Force | Out-Null
Start-BitsTransfer -Source $isoUrl -Destination $isoPath
Get-Item $isoPath | Select-Object FullName,Length,LastWriteTime
```
