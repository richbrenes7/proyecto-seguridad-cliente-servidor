# 04. Arquitectura Propuesta

## 1. Proposito de la Arquitectura
Definir una arquitectura cliente-servidor minima, realista y reproducible para implementar y validar politicas de seguridad informatica en un laboratorio local de maestria, sin uso de contenedores y sin dependencia de nube publica.

## 2. Principios de Diseno
1. Simplicidad: topologia reducida para facilitar implementacion y defensa academica.
2. Trazabilidad: cada control debe generar evidencia verificable.
3. Reproducibilidad: estructura ejecutable en equipos de estudiante con recursos moderados.
4. Seguridad por capas: controles de acceso, red, sistema, datos y monitoreo.
5. Aislamiento: laboratorio interno separado del entorno productivo o personal.

## 3. Topologia del Laboratorio
La arquitectura propuesta contiene tres maquinas virtuales y una red interna simulada:

1. Host de laboratorio
	- Equipo fisico del estudiante con virtualizacion habilitada.
	- Ejecuta Hyper-V, libvirt o VirtualBox segun plataforma.

2. VM-Servidor (Linux)
	- Rol central del entorno cliente-servidor.
	- Aloja controles de seguridad, recurso compartido, logs y respaldos.

3. VM-Cliente-1
	- Perfil de usuario estandar para pruebas de acceso restringido.

4. VM-Cliente-2
	- Perfil administrativo o avanzado para pruebas de privilegios autorizados.

5. Red interna
	- Segmento privado para comunicacion cliente-servidor.
	- Sin exposicion directa a Internet para pruebas de ataque controlado.

## 4. Dimensionamiento Sugerido de Recursos
### 4.1 VM-Servidor Linux
1. CPU: 2 vCPU.
2. Memoria: 4 GB.
3. Disco: 40 GB.

### 4.2 VM-Cliente-1
1. CPU: 2 vCPU.
2. Memoria: 4 GB.
3. Disco: 50 GB.

### 4.3 VM-Cliente-2
1. CPU: 2 vCPU.
2. Memoria: 3 a 4 GB.
3. Disco: 40 a 50 GB.

Nota: estos valores son referenciales y pueden ajustarse segun la capacidad del host.

## 5. Esquema de Red y Direccionamiento de Referencia
1. Red interna: 192.168.56.0/24.
2. Servidor Linux: 192.168.56.10.
3. Cliente-1: 192.168.56.21.
4. Cliente-2: 192.168.56.22.
5. Gateway: opcional para escenarios totalmente aislados.

## 6. Roles y Responsabilidades Tecnicas en la Arquitectura
1. Servidor Linux
	- Servicio de acceso remoto seguro (SSH).
	- Gestion de usuarios, grupos y permisos.
	- Recurso compartido protegido por ACL.
	- Registro de eventos de seguridad.
	- Ejecucion de respaldos y pruebas de restauracion.
	- Aplicacion de firewall local.

2. Clientes
	- Generacion de trafico legitimo y controlado para simulaciones.
	- Pruebas de autenticacion, autorizacion y acceso a recursos.
	- Recoleccion de evidencia de usuario final.

## 7. Servicios Minimos Requeridos
1. Acceso remoto seguro
	- OpenSSH endurecido.

2. Control de usuarios y privilegios
	- Cuentas separadas por rol.
	- Minimo privilegio y uso restringido de sudo.

3. Recurso compartido protegido
	- Directorio de datos con permisos y grupos controlados.

4. Monitoreo y auditoria
	- Registro de accesos exitosos/fallidos.
	- Registro de elevaciones de privilegio y cambios relevantes.

5. Respaldo y recuperacion
	- Copia periodica local de archivos criticos.
	- Verificacion de restauracion.

6. Control de red local
	- Firewall con politica de denegacion por defecto y aperturas minimas.

7. Servicio opcional para prueba de cifrado
	- HTTPS basico para validar proteccion en transito.

## 8. Evaluacion de Plataforma para IaC Local
### 8.1 Linux host + libvirt + Terraform
Ventajas:
1. Alta alineacion con practicas de automatizacion en Linux.
2. Ecosistema robusto para laboratorio reproducible.

Desventajas:
1. Requiere mayor experiencia tecnica inicial en KVM/libvirt.

### 8.2 Windows host + Hyper-V + Terraform
Ventajas:
1. Integracion nativa en Windows Pro/Enterprise.
2. Menor friccion para estudiantes que ya trabajan en Windows.

Desventajas:
1. Dependencia de provider comunitario, con variaciones segun version.

### 8.3 VirtualBox + Terraform
Ventajas:
1. Disponibilidad amplia y curva de entrada moderada.
2. Alternativa util en entornos heterogeneos.

Desventajas:
1. Consistencia del provider puede variar por version/plugin.

## 9. Ruta Tecnica Recomendada
Ruta principal para este proyecto academico:
1. Windows host + Hyper-V + Terraform como base adaptable.
2. Scripts Bash y PowerShell para configuracion interna de seguridad.

Ruta alternativa de mayor robustez tecnica:
1. Linux host + libvirt + Terraform.

Justificacion: la ruta principal equilibra viabilidad operativa, defendibilidad academica y reproducibilidad para estudiantes.

## 10. Dependencias y Supuestos Operativos
1. Virtualizacion habilitada en BIOS/UEFI.
2. Recursos del host suficientes para tres VMs.
3. Imagenes ISO disponibles para sistema servidor y clientes.
4. Permisos administrativos en host y maquinas virtuales.
5. Aislamiento del laboratorio para evitar impacto externo.

## 11. Criterios de Validacion Arquitectonica
La arquitectura se considera valida cuando:
1. Los tres nodos se comunican correctamente en red interna.
2. El servidor expone solo servicios necesarios y seguros.
3. Los controles de acceso y roles se verifican por simulacion.
4. Los logs permiten trazabilidad completa de eventos.
5. El mecanismo de respaldo y restauracion demuestra recuperacion efectiva.
