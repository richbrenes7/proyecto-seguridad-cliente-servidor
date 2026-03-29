# 06. Politicas de Seguridad Informatica

## 1. Politica de Acceso y Autenticacion
### Objetivo
Establecer controles de autenticacion y gestion de sesiones para asegurar que solo usuarios autorizados accedan a los servicios del laboratorio cliente-servidor.

### Alcance
Aplica al servidor Linux principal, clientes del laboratorio, servicios de acceso remoto (SSH/HTTPS) y cuentas locales de administracion y operacion.

### Lineamientos
1. La longitud minima de contrasena sera de 12 caracteres.
2. Las contrasenas deberan incluir mayusculas, minusculas, numeros y simbolos.
3. Se configurara bloqueo temporal de cuenta tras 5 intentos fallidos consecutivos.
4. Se prohibe el uso de cuentas compartidas.
5. Se deshabilitara el acceso remoto directo de root.
6. Las sesiones inactivas deberan cerrarse automaticamente.
7. El acceso remoto debera realizarse por protocolos seguros (SSH/HTTPS).

### Responsables
1. Administrador del laboratorio: implementacion tecnica de controles.
2. Responsable academico del proyecto: validacion de cumplimiento y evidencia.
3. Usuarios del laboratorio: custodia de credenciales y uso correcto.

### Cumplimiento
1. Revision mensual de registros de autenticacion.
2. Verificacion trimestral de parametros de contrasena y bloqueo.
3. Evidencia documental de configuracion en scripts y bitacoras.

### Medidas Correctivas
1. Restablecimiento inmediato de contrasenas comprometidas.
2. Bloqueo preventivo de cuentas con actividad anomala.
3. Reconfiguracion de controles de autenticacion ante desviaciones.
4. Capacitacion puntual a usuarios ante incumplimientos recurrentes.

### Relacion con Riesgos Mitigados
Mitiga principalmente acceso no autorizado, contrasenas debiles, fuerza bruta, escalacion de privilegios por credenciales comprometidas e intercepcion de sesiones inseguras.

## 2. Politica de Gestion de Usuarios
### Objetivo
Regular el ciclo de vida de identidades (alta, modificacion, baja) y la asignacion de privilegios bajo el principio de minimo privilegio.

### Alcance
Aplica a todas las cuentas de usuario del servidor y clientes, grupos locales, privilegios administrativos y accesos a recursos compartidos.

### Lineamientos
1. Toda alta, modificacion o baja de usuario debera registrarse en solicitud formal.
2. Los privilegios se asignaran por rol predefinido (administrador, operador, usuario estandar).
3. Se revisaran grupos y permisos al menos una vez por trimestre.
4. Las cuentas inactivas por 30 dias se deshabilitaran.
5. Las cuentas temporales deberan tener fecha de expiracion definida.
6. Se prohibe asignar privilegios administrativos sin justificacion tecnica.

### Responsables
1. Administrador del laboratorio: gestion de cuentas, grupos y privilegios.
2. Responsable academico: aprobacion de cambios de rol criticos.
3. Usuarios: uso exclusivo de su identidad asignada.

### Cumplimiento
1. Auditoria trimestral de cuentas activas y grupos.
2. Verificacion de trazabilidad de altas/bajas/modificaciones.
3. Muestreo de permisos sobre recursos criticos.

### Medidas Correctivas
1. Revocacion inmediata de privilegios indebidos.
2. Deshabilitacion de cuentas huérfanas o sin responsable.
3. Reasignacion de permisos conforme a perfil autorizado.
4. Registro de no conformidades y plan de mejora.

### Relacion con Riesgos Mitigados
Mitiga acceso no autorizado, usuarios internos maliciosos, escalacion de privilegios, configuraciones inseguras y errores humanos en asignacion de permisos.

## 3. Politica de Proteccion de Datos
### Objetivo
Proteger la confidencialidad, integridad y disponibilidad de la informacion del laboratorio en transito y en reposo, incluyendo mecanismos de respaldo y recuperacion.

### Alcance
Aplica a archivos de prueba, recursos compartidos, configuraciones criticas, respaldos locales y comunicaciones entre clientes y servidor.

### Lineamientos
1. Toda administracion remota se realizara con cifrado en transito (SSH/HTTPS).
2. Los datos sensibles del laboratorio deberan almacenarse con controles de permisos estrictos.
3. Se ejecutaran respaldos periodicos automatizados de recursos criticos.
4. Se realizara prueba de restauracion en periodos definidos.
5. Se conservara al menos una copia de respaldo historica verificable.
6. El acceso a repositorios de respaldo estara restringido a roles autorizados.

### Responsables
1. Administrador del laboratorio: configuracion de respaldo, restauracion y control de permisos.
2. Responsable academico: supervision de periodicidad y evidencia.
3. Usuarios autorizados: manejo adecuado de datos y reporte de incidentes.

### Cumplimiento
1. Revision semanal de ejecucion de respaldos.
2. Pruebas de restauracion documentadas con resultado exitoso.
3. Verificacion de permisos sobre directorios criticos y backups.

### Medidas Correctivas
1. Ejecucion inmediata de respaldo extraordinario ante falla de rutina.
2. Restauracion controlada ante perdida o alteracion de informacion.
3. Ajuste de permisos y hardening en ubicaciones comprometidas.
4. Investigacion y registro de causa raiz del evento.

### Relacion con Riesgos Mitigados
Mitiga perdida de informacion, alteracion de archivos, intercepcion de trafico, accesos no autorizados a datos y fallas de disponibilidad por borrado accidental o malicioso.

## 4. Politica de Uso Aceptable
### Objetivo
Definir normas de comportamiento y uso responsable de activos tecnologicos del laboratorio para reducir exposicion operacional y de seguridad.

### Alcance
Aplica a todos los usuarios del entorno de laboratorio, equipos cliente, servidor, credenciales, scripts y repositorios de evidencia.

### Lineamientos
1. El laboratorio se utilizara exclusivamente para fines academicos autorizados.
2. Se prohibe instalar software no autorizado o de origen no confiable.
3. Se prohibe compartir credenciales, llaves o sesiones activas.
4. Se prohibe desactivar controles de seguridad sin autorizacion formal.
5. Se debera reportar inmediatamente cualquier comportamiento sospechoso.
6. Toda prueba de seguridad debera ejecutarse en alcance controlado y autorizado.

### Responsables
1. Todos los usuarios del laboratorio: cumplimiento de reglas de uso.
2. Administrador del laboratorio: control tecnico de restricciones.
3. Responsable academico: seguimiento de faltas y medidas disciplinarias.

### Cumplimiento
1. Aceptacion explicita de la politica por parte de usuarios.
2. Revision periodica de eventos de uso indebido en logs.
3. Registro de incumplimientos y acciones aplicadas.

### Medidas Correctivas
1. Suspender temporalmente accesos ante uso indebido.
2. Revocar privilegios no justificados.
3. Reentrenamiento en buenas practicas de seguridad.
4. Escalamiento academico en caso de reincidencia.

### Relacion con Riesgos Mitigados
Mitiga malware por instalacion no controlada, uso interno malicioso, exposicion de credenciales, errores humanos y configuraciones inseguras.

## 5. Politica de Actualizacion y Parches
### Objetivo
Mantener sistemas y componentes del laboratorio en niveles aceptables de seguridad mediante un proceso regular y verificable de actualizacion y parcheo.

### Alcance
Aplica al sistema operativo del servidor Linux, clientes del laboratorio, paquetes de seguridad, servicios de red y herramientas de administracion.

### Lineamientos
1. Se establecera ventana semanal de mantenimiento para actualizaciones regulares.
2. Los parches criticos de seguridad se aplicaran en un plazo maximo de 72 horas.
3. Toda actualizacion debera registrarse con fecha, alcance y resultado.
4. Antes de cambios mayores, se realizara respaldo de configuraciones criticas.
5. Se verificara la estabilidad del servicio posterior al parcheo.
6. Se priorizara el parcheo de servicios expuestos y componentes de autenticacion.

### Responsables
1. Administrador del laboratorio: ejecucion tecnica de parches y validaciones.
2. Responsable academico: aprobacion del calendario y seguimiento.
3. Usuarios: reporte de fallas funcionales posteriores a cambios.

### Cumplimiento
1. Bitacora de parcheo actualizada por cada ventana de mantenimiento.
2. Revision mensual de versiones y vulnerabilidades conocidas.
3. Evidencia de pruebas de verificacion post-actualizacion.

### Medidas Correctivas
1. Aplicacion de parche extraordinario ante vulnerabilidad critica.
2. Rollback o restauracion controlada ante impacto operativo severo.
3. Ajuste del calendario si se detecta acumulacion de deuda de parches.
4. Actualizacion de procedimiento para evitar recurrencia.

### Relacion con Riesgos Mitigados
Mitiga vulnerabilidades por falta de parches, compromisos por software desactualizado, escalacion de privilegios por CVEs conocidas y afectaciones de disponibilidad por incidentes prevenibles.

## 6. Politica de Monitoreo y Auditoria
### Objetivo
Garantizar la deteccion oportuna, registro y analisis de eventos de seguridad para mantener trazabilidad de actividades y soporte a investigaciones.

### Alcance
Aplica a logs de autenticacion, uso de privilegios, cambios de configuracion, eventos de firewall, respaldos y actividades relevantes en servidor y clientes.

### Lineamientos
1. Se registraran accesos exitosos y fallidos.
2. Se registraran eventos de elevacion de privilegios y cambios criticos.
3. Se definira una frecuencia minima de revision de logs (semanal).
4. Los registros deberan incluir marca de tiempo, origen y usuario.
5. Se conservara evidencia de auditoria durante el periodo academico del proyecto.
6. Se estableceran alertas basicas para patrones anormales (fallos repetidos, intentos de acceso inusual).

### Responsables
1. Administrador del laboratorio: configuracion y custodia de logs.
2. Responsable academico: revision de reportes de auditoria.
3. Equipo de proyecto: analisis de hallazgos y acciones de mejora.

### Cumplimiento
1. Informe semanal de eventos relevantes.
2. Verificacion de integridad y disponibilidad de registros.
3. Evidencia de correlacion de eventos en simulaciones de seguridad.

### Medidas Correctivas
1. Ajuste de niveles de logging ante brechas de trazabilidad.
2. Correccion de relojes/sincronizacion cuando existan inconsistencias temporales.
3. Activacion de monitoreo reforzado ante incidentes recurrentes.
4. Reentrenamiento operativo sobre interpretacion de eventos.

### Relacion con Riesgos Mitigados
Mitiga falta de auditoria, deteccion tardia de incidentes, errores humanos no trazables, acceso no autorizado no detectado y dificultades de analisis forense basico.

## 7. Politica de Respuesta ante Incidentes
### Objetivo
Establecer un procedimiento formal y repetible para gestionar incidentes de seguridad desde su deteccion hasta la recuperacion y mejora continua.

### Alcance
Aplica a incidentes de autenticacion, compromisos de cuenta, alteracion o perdida de datos, malware en entorno de pruebas, fallas de servicio y eventos anormales de seguridad.

### Lineamientos
1. Todo incidente debera clasificarse y registrarse al momento de su deteccion.
2. Se aplicaran acciones de contencion proporcionadas al impacto (bloqueo de cuenta, aislamiento de servicio, restriccion de acceso).
3. Se realizara analisis de causa raiz y alcance tecnico.
4. Se ejecutara recuperacion controlada con validacion funcional.
5. Se documentaran lecciones aprendidas y mejoras al marco de control.
6. Se mantendra cadena de evidencia tecnica para defensa academica.

### Responsables
1. Administrador del laboratorio: ejecucion de contencion y recuperacion tecnica.
2. Responsable academico: coordinacion, aprobacion de cierre e informe final.
3. Equipo de proyecto: documentacion de incidente y recomendaciones.

### Cumplimiento
1. Uso obligatorio de formato de registro de incidente.
2. Verificacion de tiempos de respuesta y acciones aplicadas.
3. Cierre formal con evidencia y plan preventivo de mejora.

### Medidas Correctivas
1. Endurecimiento adicional de controles comprometidos.
2. Ajuste de politicas y procedimientos segun lecciones aprendidas.
3. Reconfiguracion de accesos, contrasenas y permisos afectados.
4. Simulacion posterior para validar efectividad de correcciones.

### Relacion con Riesgos Mitigados
Mitiga impacto operativo por incidentes, reincidencia de fallas de seguridad, perdida de evidencia, indisponibilidad prolongada y degradacion de la postura de seguridad por ausencia de respuesta estructurada.
