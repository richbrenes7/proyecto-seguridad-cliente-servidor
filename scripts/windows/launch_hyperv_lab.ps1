[CmdletBinding()]
param(
    [string]$SwitchName = 'red-interna-lab',
    [string]$VmRootPath = 'C:\HyperV\LabSeguridad',
    [string]$ServerName = 'srv-linux-seg',
    [string[]]$ClientNames = @('cli-01', 'cli-02'),
    [int]$ServerCpu = 2,
    [int]$ServerMemoryMB = 4096,
    [int]$ServerDiskGB = 40,
    [int]$ClientCpu = 2,
    [int]$ClientMemoryMB = 4096,
    [int]$ClientDiskGB = 50,
    [string]$ServerIsoPath = '',
    [string]$ClientIsoPath = '',
    [string]$ClientIsoUrl = '',
    [string]$ClientIsoSha256 = '',
    [switch]$NoOpenWindowsDownloadPage,
    [switch]$StartVMs
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent (Split-Path -Parent $ScriptDir)
$LocalIsoDir = Join-Path $RepoRoot '.local\isos'
$Windows10DownloadUrl = 'https://www.microsoft.com/software-download/windows10'

function Test-IsAdmin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function Ensure-Admin {
    if (-not (Test-IsAdmin)) {
        throw 'Este script requiere PowerShell como Administrador.'
    }
}

function Ensure-HyperVModule {
    if (Get-Module -ListAvailable -Name Hyper-V) {
        Import-Module Hyper-V -ErrorAction Stop
        return
    }

    $hint = @(
        'No se encontro el modulo Hyper-V en PowerShell.',
        'Habilita estas caracteristicas en una consola Administrador y reinicia:',
        '  Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -All',
        '  Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Management-PowerShell -All'
    ) -join [Environment]::NewLine

    throw $hint
}

function Ensure-VMSwitch {
    param([Parameter(Mandatory)] [string]$Name)

    $switch = Get-VMSwitch -Name $Name -ErrorAction SilentlyContinue
    if ($null -eq $switch) {
        Write-Host "Creando vSwitch interno: $Name"
        New-VMSwitch -Name $Name -SwitchType Internal | Out-Null
    }
    else {
        Write-Host "vSwitch ya existe: $Name"
    }
}

function Download-File {
    param(
        [Parameter(Mandatory)] [string]$Url,
        [Parameter(Mandatory)] [string]$DestinationPath
    )

    New-Item -Path (Split-Path -Parent $DestinationPath) -ItemType Directory -Force | Out-Null

    try {
        Start-BitsTransfer -Source $Url -Destination $DestinationPath -ErrorAction Stop
    }
    catch {
        Write-Warning "BITS fallo, reintentando con Invoke-WebRequest: $Url"
        Invoke-WebRequest -Uri $Url -OutFile $DestinationPath -UseBasicParsing
    }
}

function Test-FileHash {
    param(
        [Parameter(Mandatory)] [string]$Path,
        [Parameter(Mandatory)] [string]$ExpectedSha256
    )

    $actual = (Get-FileHash -Path $Path -Algorithm SHA256).Hash
    if ($actual -ne $ExpectedSha256.ToUpperInvariant()) {
        throw "El hash SHA256 no coincide para '$Path'. Esperado: $ExpectedSha256. Obtenido: $actual."
    }
}

function Resolve-IsoPaths {
    New-Item -Path $LocalIsoDir -ItemType Directory -Force | Out-Null

    if (-not $ServerIsoPath) {
        $defaultServerIso = Join-Path $LocalIsoDir 'ubuntu-22.04.5-live-server-amd64.iso'
        if (Test-Path $defaultServerIso) {
            $script:ServerIsoPath = $defaultServerIso
            Write-Host "Usando ISO servidor por defecto: $ServerIsoPath"
        }
    }

    if (-not $ClientIsoPath) {
        $defaultClientIsoCandidates = @(
            (Join-Path $LocalIsoDir 'windows10.iso'),
            (Join-Path $LocalIsoDir 'windows11.iso')
        )

        foreach ($candidate in $defaultClientIsoCandidates) {
            if (Test-Path $candidate) {
                $script:ClientIsoPath = $candidate
                Write-Host "Usando ISO cliente por defecto: $ClientIsoPath"
                break
            }
        }

        if (-not $script:ClientIsoPath) {
            if ($ClientIsoUrl) {
                Write-Host "Descargando ISO cliente desde URL configurada..."
                $downloadClientIso = Join-Path $LocalIsoDir 'windows10.iso'
                Download-File -Url $ClientIsoUrl -DestinationPath $downloadClientIso

                if (Test-Path $downloadClientIso) {
                    $script:ClientIsoPath = $downloadClientIso
                    Write-Host "ISO cliente descargada: $ClientIsoPath"
                }
                else {
                    Write-Warning "No se pudo descargar la ISO cliente desde: $ClientIsoUrl"
                }
            }

            if (-not $script:ClientIsoPath) {
                Write-Warning "No se encontro windows10.iso ni windows11.iso en $LocalIsoDir y no se configuro una URL valida."
                Write-Host "Descarga oficial de Windows 10: $Windows10DownloadUrl"

                if (-not $NoOpenWindowsDownloadPage) {
                    try {
                        Start-Process $Windows10DownloadUrl | Out-Null
                    }
                    catch {
                        Write-Warning 'No se pudo abrir automaticamente el navegador. Abre la URL manualmente.'
                    }
                }
            }
        }
    }

    if ($ClientIsoPath -and $ClientIsoSha256) {
        if (-not (Test-Path $ClientIsoPath)) {
            throw "La ISO cliente no existe para validar hash: $ClientIsoPath"
        }

        Test-FileHash -Path $ClientIsoPath -ExpectedSha256 $ClientIsoSha256
        Write-Host "Hash SHA256 validado para la ISO cliente."
    }
}

function New-LabVM {
    param(
        [Parameter(Mandatory)] [string]$Name,
        [Parameter(Mandatory)] [int]$Cpu,
        [Parameter(Mandatory)] [int]$MemoryMB,
        [Parameter(Mandatory)] [int]$DiskGB,
        [Parameter(Mandatory)] [string]$Switch,
        [Parameter(Mandatory)] [string]$RootPath,
        [string]$IsoPath
    )

    $existing = Get-VM -Name $Name -ErrorAction SilentlyContinue
    if ($null -ne $existing) {
        Write-Host "VM ya existe, se omite: $Name"
        return
    }

    $vmPath = Join-Path $RootPath $Name
    $vhdPath = Join-Path $vmPath "$Name.vhdx"
    $memoryBytes = [UInt64]$MemoryMB * 1MB
    $diskBytes = [UInt64]$DiskGB * 1GB

    New-Item -Path $vmPath -ItemType Directory -Force | Out-Null

    Write-Host "Creando VM: $Name"
    New-VM -Name $Name -Generation 2 -MemoryStartupBytes $memoryBytes -NewVHDPath $vhdPath -NewVHDSizeBytes $diskBytes -Path $vmPath -SwitchName $Switch | Out-Null

    Set-VMProcessor -VMName $Name -Count $Cpu
    Set-VMMemory -VMName $Name -DynamicMemoryEnabled $false -StartupBytes $memoryBytes

    if ($IsoPath -and (Test-Path $IsoPath)) {
        $dvd = Get-VMDvdDrive -VMName $Name -ErrorAction SilentlyContinue
        if ($null -eq $dvd) {
            Add-VMDvdDrive -VMName $Name -Path $IsoPath | Out-Null
        }
        else {
            Set-VMDvdDrive -VMName $Name -Path $IsoPath
        }
    }
    elseif ($IsoPath) {
        Write-Warning "ISO no encontrada para $($Name): $IsoPath"
    }
}

Ensure-Admin
Ensure-HyperVModule
Resolve-IsoPaths
New-Item -Path $VmRootPath -ItemType Directory -Force | Out-Null
Ensure-VMSwitch -Name $SwitchName

New-LabVM -Name $ServerName -Cpu $ServerCpu -MemoryMB $ServerMemoryMB -DiskGB $ServerDiskGB -Switch $SwitchName -RootPath $VmRootPath -IsoPath $ServerIsoPath

foreach ($client in $ClientNames) {
    New-LabVM -Name $client -Cpu $ClientCpu -MemoryMB $ClientMemoryMB -DiskGB $ClientDiskGB -Switch $SwitchName -RootPath $VmRootPath -IsoPath $ClientIsoPath
}

if ($StartVMs) {
    $allNames = @($ServerName) + $ClientNames
    foreach ($vmName in $allNames) {
        Write-Host "Iniciando VM: $vmName"
        Start-VM -Name $vmName | Out-Null
    }
}

Write-Host ''
Write-Host 'Lanzamiento base completado.'
Write-Host "vSwitch: $SwitchName"
Write-Host "Ruta de VMs: $VmRootPath"
Write-Host 'Siguiente paso: instalar SO, configurar IPs estaticas y validar conectividad cliente-servidor.'
