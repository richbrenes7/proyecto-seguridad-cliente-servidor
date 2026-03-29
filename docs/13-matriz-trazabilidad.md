# 13. Matriz de Trazabilidad Riesgo-Politica-Control-Simulacion

| Riesgo | Politica asociada | Control aplicado | Simulacion asociada | Evidencia esperada |
|---|---|---|---|---|
| Acceso no autorizado | Acceso y autenticacion | Contrasenas robustas, bloqueo por intentos, restriccion SSH | S1 | Logs de auth y bloqueo |
| Fuerza bruta SSH | Acceso y autenticacion | MaxAuthTries, fail2ban/pam_faillock, firewall | S1 y S5 | Eventos de bloqueo e IP origen |
| Escalacion de privilegios | Gestion de usuarios | Roles, grupos y sudo restringido | S2 | Denegacion a usuario estandar |
| Perdida de informacion | Proteccion de datos | Backup programado y restauracion probada | S4 | Archivo restaurado integro |
| Intercepcion de trafico | Proteccion de datos | Uso de SSH/HTTPS y deshabilitacion de protocolos inseguros | S3 | Prueba de conexion cifrada |
| Falta de auditoria | Monitoreo y auditoria | Registro central local de eventos y revision periodica | S5 | Extractos de logs correlacionados |
| Vulnerabilidades sin parche | Actualizacion y parches | Calendario semanal y parcheo critico priorizado | S6 | Registro de cambios y versionado |
| Error humano | Uso aceptable y procedimientos | Checklist, scripts estandar y control de cambios | S6 | Bitacora de incidente y mejoras |
| Uso interno malicioso | Uso aceptable + gestion de usuarios | Restriccion por rol y trazabilidad de acciones | S2 y S5 | Evidencia de denegaciones y logs |
| Alteracion de archivos | Proteccion de datos + auditoria | ACL, permisos estrictos y monitoreo de eventos | S4 y S5 | Cambios detectados y recuperados |
