param(
    [string]$Servidor = "192.168.56.10",
    [string]$Recurso = "datos_compartidos"
)

Write-Host "== Preparando usuarios locales de laboratorio =="

$users = @(
    @{ Name = "lab_user"; FullName = "Usuario Estandar Laboratorio"; Group = "Users" },
    @{ Name = "lab_admin"; FullName = "Administrador Laboratorio"; Group = "Administrators" }
)

foreach ($u in $users) {
    if (-not (Get-LocalUser -Name $u.Name -ErrorAction SilentlyContinue)) {
        $pwd = Read-Host "Contrasena para $($u.Name)" -AsSecureString
        New-LocalUser -Name $u.Name -Password $pwd -FullName $u.FullName -PasswordNeverExpires:$false | Out-Null
        Add-LocalGroupMember -Group $u.Group -Member $u.Name
        Write-Host "Creado: $($u.Name) en grupo $($u.Group)"
    } else {
        Write-Host "Ya existe: $($u.Name)"
    }
}

Write-Host "`n== Prueba de acceso a recurso compartido =="
$sharePath = "\\$Servidor\$Recurso"

try {
    New-PSDrive -Name "LAB" -PSProvider FileSystem -Root $sharePath -ErrorAction Stop | Out-Null
    Write-Host "Acceso al recurso correcto: $sharePath"
    Get-ChildItem "LAB:\" -ErrorAction SilentlyContinue | Select-Object -First 5
    Remove-PSDrive -Name "LAB" -Force -ErrorAction SilentlyContinue
}
catch {
    Write-Warning "No se pudo acceder al recurso compartido. Verificar permisos y conectividad."
    Write-Warning $_.Exception.Message
}

Write-Host "`n== Evidencia basica del cliente =="
Get-Date
whoami
ipconfig | Select-String "IPv4"
