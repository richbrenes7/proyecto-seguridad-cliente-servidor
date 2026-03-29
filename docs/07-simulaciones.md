# 07. Simulaciones

## S1. Intentos Fallidos de Autenticacion
### Nombre
Intentos fallidos de autenticacion en acceso remoto SSH.

### Objetivo
Validar bloqueo y trazabilidad ante intentos de acceso no exitosos.

### Riesgo asociado
1. Acceso no autorizado.
2. Fuerza bruta sobre servicio SSH.

### Politica relacionada
1. Politica de acceso y autenticacion.
2. Politica de monitoreo y auditoria.

### Recursos necesarios
1. Servidor Linux con SSH habilitado.
2. Cliente con terminal SSH.
3. Cuenta de usuario de prueba.
4. Logs de autenticacion activos (auth.log o journalctl).

### Procedimiento
1. Intentar autenticacion SSH con contrasena incorrecta repetidamente.
2. Verificar bloqueo temporal de cuenta o retardo de autenticacion.
3. Revisar logs de autenticacion en servidor.
4. Confirmar registro de intentos con usuario, IP y marca de tiempo.

### Resultado esperado
1. Registro claro de intentos fallidos.
2. Activacion de control de bloqueo o mitigacion.

### Evidencia a recopilar
1. Captura de intentos fallidos desde cliente.
2. Extracto de logs con eventos de fallo y bloqueo.
3. Evidencia de estado de cuenta o servicio tras bloqueo.

## S2. Acceso Segun Roles
### Nombre
Validacion de control de acceso basado en roles y minimo privilegio.

### Objetivo
Demostrar aplicacion del minimo privilegio.

### Riesgo asociado
1. Escalacion de privilegios.
2. Acceso indebido a recursos restringidos.

### Politica relacionada
1. Politica de gestion de usuarios.
2. Politica de acceso y autenticacion.

### Recursos necesarios
1. Servidor Linux con grupos y permisos configurados.
2. Recurso compartido protegido (directorio de prueba).
3. Usuario estandar y usuario administrador.
4. Comandos de validacion de permisos (id, groups, ls -l, getfacl).

### Procedimiento
1. Usuario estandar intenta acceder a recurso restringido.
2. Administrador accede al mismo recurso con autorizacion.
3. Revisar permisos del sistema de archivos y grupos.
4. Registrar en bitacora el resultado de ambos accesos.

### Resultado esperado
1. Denegacion para perfil no autorizado.
2. Acceso exitoso para perfil autorizado.

### Evidencia a recopilar
1. Salida de comandos de identidad y grupos por usuario.
2. Captura de denegacion de acceso para usuario estandar.
3. Captura de acceso exitoso para usuario administrador.
4. Evidencia de ACL o permisos del recurso.

## S3. Comunicacion Segura
### Nombre
Validacion de cifrado en transito para comunicacion cliente-servidor.

### Objetivo
Validar cifrado en transito para administracion y/o acceso web.

### Riesgo asociado
1. Intercepcion de trafico.
2. Exposicion de credenciales en texto plano.

### Politica relacionada
1. Politica de proteccion de datos.
2. Politica de acceso y autenticacion.

### Recursos necesarios
1. Servidor Linux con SSH y/o HTTPS.
2. Cliente con herramientas SSH y navegador o curl.
3. Certificado de prueba para HTTPS (si aplica).
4. Configuracion de puertos en firewall.

### Procedimiento
1. Establecer sesion SSH o HTTPS hacia servidor.
2. Verificar uso de protocolo seguro y certificados (si aplica HTTPS).
3. Confirmar rechazo de protocolos inseguros.
4. Registrar version de protocolo y cifrado negociado.

### Resultado esperado
Sesion segura y sin exposicion de credenciales en texto plano.

### Evidencia a recopilar
1. Captura de conexion SSH/HTTPS exitosa.
2. Evidencia de protocolo y cifrado utilizado.
3. Registro de rechazo de intento inseguro (si se ejecuta prueba negativa).
4. Fragmento de configuracion de servicio seguro.

## S4. Respaldo y Recuperacion
### Nombre
Prueba de respaldo periodico y restauracion de archivo critico.

### Objetivo
Comprobar recuperacion de datos ante perdida o alteracion.

### Riesgo asociado
1. Perdida de informacion.
2. Alteracion de archivos por error o accion maliciosa.

### Politica relacionada
1. Politica de proteccion de datos.
2. Politica de respuesta ante incidentes.

### Recursos necesarios
1. Directorio de datos compartidos en servidor.
2. Script o mecanismo de respaldo configurado.
3. Archivo de prueba con huella o checksum.
4. Almacenamiento de respaldo local.

### Procedimiento
1. Crear archivo de prueba en recurso protegido.
2. Ejecutar respaldo.
3. Alterar o eliminar archivo.
4. Restaurar desde respaldo.
5. Comparar integridad antes y despues de la restauracion.

### Resultado esperado
Recuperacion integra del archivo.

### Evidencia a recopilar
1. Registro de ejecucion de respaldo (fecha y hora).
2. Evidencia de eliminacion o alteracion del archivo.
3. Evidencia de restauracion exitosa.
4. Comparacion de checksum o contenido recuperado.

## S5. Monitoreo y Auditoria
### Nombre
Deteccion y trazabilidad de actividad sospechosa en logs.

### Objetivo
Verificar capacidad de deteccion de actividad sospechosa.

### Riesgo asociado
1. Falta de auditoria.
2. Deteccion tardia de eventos de seguridad.

### Politica relacionada
1. Politica de monitoreo y auditoria.
2. Politica de acceso y autenticacion.

### Recursos necesarios
1. Logging activo (rsyslog/journald/auditd).
2. Eventos controlados de prueba (fallos de login, uso de sudo).
3. Herramientas de consulta de logs (journalctl, grep, tail).
4. Plantilla de bitacora para correlacion de eventos.

### Procedimiento
1. Generar eventos controlados (fallos de acceso, uso de sudo).
2. Consultar logs relevantes.
3. Correlacionar hora, usuario y accion.
4. Clasificar eventos en normales y sospechosos.

### Resultado esperado
Eventos auditables y consistentes.

### Evidencia a recopilar
1. Extractos de logs con timestamp, usuario y origen.
2. Registro de correlacion de eventos.
3. Evidencia de al menos un patron sospechoso identificado.

## S6. Respuesta ante Incidente
### Nombre
Ejecucion del ciclo de respuesta ante incidente en laboratorio.

### Objetivo
Ejecutar ciclo basico de manejo de incidente.

### Riesgo asociado
1. Impacto prolongado por ausencia de respuesta estructurada.
2. Reincidencia por falta de analisis de causa raiz.

### Politica relacionada
1. Politica de respuesta ante incidentes.
2. Politica de monitoreo y auditoria.
3. Politica de actualizacion y parches (si aplica remediacion).

### Recursos necesarios
1. Escenario de incidente controlado (cuenta comprometida simulada o cambio no autorizado).
2. Acceso administrativo al servidor.
3. Formato de registro de incidente.
4. Evidencia de logs, configuraciones y acciones ejecutadas.

### Procedimiento
1. Detectar evento sospechoso.
2. Contener (bloquear IP/cuenta o aislar servicio).
3. Analizar causa probable.
4. Recuperar servicio o configuracion.
5. Documentar lecciones aprendidas.
6. Definir accion preventiva para evitar recurrencia.

### Resultado esperado
Incidente controlado con documentacion completa.

### Evidencia a recopilar
1. Registro cronologico de deteccion, contencion, analisis y recuperacion.
2. Evidencia de estado previo y posterior al incidente.
3. Lista de lecciones aprendidas y plan de mejora.
4. Validacion de servicio restablecido.
