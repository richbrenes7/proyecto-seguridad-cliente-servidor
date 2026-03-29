# Terraform para Laboratorio Local: Guia de Adaptacion por Plataforma

## 1. Alcance
Esta carpeta define una plantilla base de Terraform para un laboratorio cliente-servidor local con maquinas virtuales.

Condiciones del diseno:
1. Sin contenedores.
2. Sin nube publica.
3. Despliegue en host local mediante virtualizacion.

## 2. Objetivo de la Plantilla
La plantilla busca estandarizar:
1. Nombre del proyecto.
2. Red interna del laboratorio.
3. Nombres de servidor y clientes.
4. Perfiles de recursos (CPU, memoria y disco).

Adicionalmente, genera un inventario local para trazabilidad academica, incluso cuando el aprovisionamiento final dependa del provider.

## 3. Archivos incluidos
1. main.tf: estructura principal y puntos de extension por provider.
2. variables.tf: variables del laboratorio (proyecto, red, VMs, recursos).
3. outputs.tf: salidas de inventario y perfiles aplicados.
4. terraform.tfvars.example: ejemplo editable para tu entorno.
5. README.md: esta guia de adaptacion.

## 4. Flujo base recomendado
1. Copiar terraform.tfvars.example como terraform.tfvars.
2. Ajustar nombres, red y recursos de VMs.
3. Ejecutar terraform init.
4. Ejecutar terraform plan.
5. Ejecutar terraform apply.

Nota: si todavia no integras un provider de virtualizacion, la plantilla seguira siendo util para inventario y documentacion tecnica.

## 5. Variables clave que debes ajustar
1. project_name
2. network_name
3. network_cidr
4. server_name
5. client_names
6. server_cpu, server_memory_mb, server_disk_gb
7. client_cpu, client_memory_mb, client_disk_gb

## 6. Adaptacion a Linux + libvirt
### 6.1 Cuándo conviene
1. Host Linux.
2. Entorno academico orientado a automatizacion con KVM/QEMU.

### 6.2 Pasos de adaptacion
1. Instalar libvirt y KVM en el host.
2. Instalar el provider Terraform de libvirt compatible con tu version.
3. En main.tf, agregar/descomentar el bloque provider libvirt.
4. Crear la red virtual interna con network_name y network_cidr.
5. Definir recursos de almacenamiento (volumenes) para servidor y clientes.
6. Definir dominios/VMs mapeando:
	- servidor: server_name, server_cpu, server_memory_mb, server_disk_gb
	- clientes: client_names, client_cpu, client_memory_mb, client_disk_gb
7. Validar conectividad entre VMs y acceso SSH al servidor.

### 6.3 Consideraciones
1. Ruta robusta para IaC local.
2. Requiere conocimiento tecnico medio en virtualizacion Linux.

## 7. Adaptacion a Windows + Hyper-V
### 7.1 Cuándo conviene
1. Host Windows 10/11 Pro o Enterprise.
2. Entorno de estudiante con ecosistema Windows.

### 7.2 Pasos de adaptacion
1. Habilitar Hyper-V y reiniciar host.
2. Instalar provider Terraform de Hyper-V compatible.
3. En main.tf, agregar/descomentar bloque provider Hyper-V.
4. Crear o referenciar un vSwitch interno con network_name.
5. Definir discos VHDX para servidor y clientes (tamano segun variables de disco).
6. Definir VMs usando variables de nombre, CPU y memoria.
7. Configurar direccionamiento interno y validar comunicacion cliente-servidor.

### 7.3 Consideraciones
1. Integracion nativa en Windows.
2. Revisar compatibilidad del provider antes de automatizar todo el ciclo.

## 8. Adaptacion a VirtualBox
### 8.1 Cuándo conviene
1. Necesidad de compatibilidad multiplataforma.
2. Entorno academico con requerimientos de instalacion simple.

### 8.2 Pasos de adaptacion
1. Instalar VirtualBox en el host.
2. Instalar provider Terraform de VirtualBox compatible.
3. En main.tf, agregar/descomentar bloque provider virtualbox.
4. Definir red interna para laboratorio con network_name.
5. Crear VM servidor y VMs cliente mapeando variables de recursos.
6. Configurar IPs internas y validar conectividad y servicios.

### 8.3 Consideraciones
1. Facil de iniciar.
2. Mayor variabilidad de soporte segun versiones de plugin/provider.

## 9. Criterio para elegir plataforma
1. Si tu host es Linux y tienes experiencia tecnica: libvirt.
2. Si tu host es Windows y buscas menor friccion: Hyper-V.
3. Si priorizas compatibilidad general: VirtualBox.

## 10. Buenas practicas de documentacion academica
1. Registrar provider y version usados.
2. Guardar salida de terraform plan y terraform apply como evidencia.
3. Documentar cambios de variables respecto al archivo de ejemplo.
4. Explicar limites tecnicos encontrados en la implementacion local.

## 11. Declaracion final
Esta plantilla esta diseñada como base adaptable. La implementacion exacta de recursos de VM depende del provider local seleccionado y su nivel de compatibilidad con la version de Terraform instalada.
