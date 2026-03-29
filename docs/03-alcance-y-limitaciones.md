# 03. Alcance y Limitaciones

## Alcance
1. Laboratorio local en host fisico unico.
2. Infraestructura virtual sin contenedores.
3. Un servidor Linux principal y dos clientes.
4. Red interna simulada para pruebas controladas.
5. Implementacion de politicas de seguridad en:
   - acceso y autenticacion
   - gestion de usuarios y privilegios
   - proteccion de datos
   - uso aceptable
   - actualizacion y parches
   - monitoreo y auditoria
   - respuesta ante incidentes
6. Simulaciones tecnicas con evidencia.

## Supuestos
1. El estudiante dispone de equipo con recursos de virtualizacion suficientes.
2. Se cuenta con permisos administrativos en host y VMs.
3. El laboratorio no esta expuesto a Internet publica de forma directa.
4. Se dispone de imagen ISO Linux y cliente(s) para pruebas.

## Limitaciones
1. No se persigue certificacion formal de cumplimiento normativo.
2. Los resultados se acotan al entorno de laboratorio.
3. Algunos controles avanzados (SIEM empresarial, EDR comercial, MFA con proveedor externo) pueden representarse de forma simplificada.
4. Terraform para aprovisionamiento local depende del proveedor disponible y mantenido para la plataforma elegida.

## Entregables
1. Documentacion academica completa.
2. Plantillas IaC de laboratorio.
3. Scripts de configuracion y prueba.
4. Matriz de riesgos y matriz de trazabilidad.
5. Guia de simulaciones y evidencias.
