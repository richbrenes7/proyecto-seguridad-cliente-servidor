# Propuesta Academica Formal

## Titulo
Diseno e implementacion de politicas de seguridad informatica para una arquitectura cliente-servidor en laboratorio local virtualizado

## Introduccion
La seguridad informatica constituye un componente estrategico en la gestion de arquitecturas cliente-servidor, particularmente en escenarios donde convergen multiples usuarios, servicios centralizados y recursos compartidos. En dicho contexto, la ausencia de controles formales puede derivar en brechas que afecten de manera directa la confidencialidad, integridad y disponibilidad de la informacion.

La presente propuesta de maestria plantea un marco metodologico para el diseno, implementacion y validacion de politicas de seguridad informatica en un entorno de laboratorio local basado en maquinas virtuales, sin empleo de contenedores. El enfoque integra componentes normativos y tecnicos, con el proposito de producir evidencia verificable y defendible sobre la eficacia de los controles aplicados.

## Planteamiento del Problema
En entornos academicos y de laboratorio es frecuente la implementacion de arquitecturas cliente-servidor sin un marco de seguridad sistematico. Esta situacion se manifiesta en:
1. Gestion insuficiente de identidades y privilegios.
2. Controles limitados de proteccion de datos en transito y en reposo.
3. Deficiencias en monitoreo, auditoria y trazabilidad.
4. Procesos no estandarizados de respaldo, restauracion y respuesta ante incidentes.

En consecuencia, la investigacion se orienta a resolver la falta de articulacion entre analisis de riesgos, politicas formales, controles implementados y mecanismos de validacion empirica.

## Diagnostico del Entorno Cliente-Servidor
El entorno de laboratorio se compone de una arquitectura cliente-servidor virtualizada con tres nodos principales:
1. Un servidor Linux (`srv-linux-seg`) para servicios, control de acceso, auditoria y respaldo.
2. Dos clientes Windows (`cli-01` y `cli-02`) para pruebas de autenticacion, acceso segun roles y generacion de evidencia.
3. Una red interna aislada en Hyper-V para simular comunicacion cliente-servidor sin exponer el laboratorio a redes externas.

Activos informaticos identificados:
1. Credenciales de usuarios administrativos y estandar.
2. Datos almacenados en el recurso compartido del servidor.
3. Servicio SSH para administracion remota segura.
4. Logs de autenticacion, auditoria y eventos del sistema.
5. Respaldos locales del directorio critico del laboratorio.

Riesgos y amenazas priorizados:
1. Intentos de acceso no autorizado por fuerza bruta o uso indebido de credenciales.
2. Escalacion de privilegios por configuraciones deficientes de roles y permisos.
3. Exposicion o alteracion de informacion por ausencia de respaldo o controles de acceso.
4. Falta de trazabilidad ante incidentes si no se preservan logs y evidencia tecnica.

## Justificacion
1. Pertinencia academica: articula teoria de seguridad, analisis de riesgos y comprobacion experimental en un proyecto de posgrado.
2. Pertinencia tecnica: demuestra que un conjunto coherente de politicas y controles disminuye riesgos de alta recurrencia.
3. Viabilidad operativa: se ejecuta en laboratorio local con recursos accesibles para estudiantes.

## Objetivo General
Disenar, implementar y validar un conjunto de politicas de seguridad informatica aplicadas a una arquitectura cliente-servidor en laboratorio local virtualizado, con la finalidad de fortalecer la postura de seguridad frente a amenazas comunes.

## Objetivos Especificos
1. Identificar activos criticos y vectores de riesgo del entorno cliente-servidor.
2. Evaluar amenazas mediante una matriz de riesgos cualitativa.
3. Redactar politicas formales de seguridad para acceso, usuarios, datos, uso aceptable, parcheo, auditoria y respuesta ante incidentes.
4. Implementar controles tecnicos base en servidor y clientes del laboratorio.
5. Ejecutar simulaciones controladas para validar la eficacia de las politicas.
6. Documentar resultados, limitaciones y recomendaciones bajo criterios academicos.

## Alcance
1. Laboratorio local sin contenedores, sustentado en maquinas virtuales.
2. Arquitectura minima de tres nodos: un servidor Linux y dos clientes.
3. Red interna simulada para ejecucion de pruebas de seguridad.
4. Implementacion y evaluacion de controles de acceso, autenticacion, autorizacion, proteccion de datos, monitoreo, respaldos, actualizaciones y respuesta ante incidentes.
5. Generacion de evidencia tecnica para validacion y defensa del proyecto.

## Limitaciones
1. Los hallazgos corresponden a un entorno de laboratorio y no equivalen a certificacion de un entorno productivo.
2. La capacidad del host puede restringir el grado de complejidad de escenarios simultaneos.
3. El uso de Terraform para aprovisionamiento de VMs depende de la disponibilidad y estabilidad del provider local.
4. Controles avanzados de nivel empresarial se abordaran como lineas de extension futura.

## Solucion Propuesta
La solucion se estructura en cuatro componentes integrados:
1. Componente normativo: politicas formales con criterios de objetivo, alcance, lineamientos, responsables, cumplimiento y medidas correctivas.
2. Componente tecnico: implementacion de controles en host servidor y clientes, incluyendo endurecimiento de acceso remoto, control de privilegios, firewall, monitoreo y respaldos.
3. Componente de trazabilidad: vinculacion explicita entre riesgo identificado, politica aplicable, control ejecutado, simulacion y evidencia.
4. Componente de validacion: simulaciones reproducibles para verificar la efectividad de los controles frente a amenazas definidas.

## Arquitectura del Laboratorio
La arquitectura propuesta contempla:
1. Un servidor Linux principal como nodo de servicios y controles de seguridad.
2. Dos clientes para pruebas comparativas de roles y privilegios.
3. Una red interna aislada para simulaciones controladas.

Sobre dicha arquitectura se habilitan, como minimo, servicios de acceso remoto seguro, gestion de usuarios, recurso compartido protegido, auditoria de eventos, respaldo y recuperacion.

## Herramientas
1. Plataforma de virtualizacion local: Hyper-V, libvirt o VirtualBox.
2. Infraestructura como codigo opcional: Terraform como base de aprovisionamiento adaptable.
3. Sistema operativo servidor: Linux con servicios de seguridad y auditoria.
4. Automatizacion de configuraciones: scripts Bash para Linux y PowerShell para clientes Windows.
5. Evidencia y documentacion: archivos Markdown, bitacoras y registros de ejecucion.

## Simulaciones
El proyecto contempla seis simulaciones minimas:
1. Intentos fallidos de autenticacion.
2. Control de acceso por roles.
3. Comunicacion segura por SSH y/o HTTPS.
4. Respaldo y recuperacion de informacion.
5. Monitoreo de actividad sospechosa.
6. Respuesta estructurada ante incidente.

Cada simulacion define objetivo, riesgo asociado, politica relacionada, recursos requeridos, procedimiento, resultado esperado y evidencia a recopilar.

## Resultados Esperados
1. Implementacion verificable de politicas de seguridad en entorno cliente-servidor.
2. Reduccion observable de riesgos priorizados en la matriz.
3. Evidencia tecnica consistente para sustentacion academica.
4. Reproducibilidad metodologica del laboratorio por terceros.
5. Base de referencia para futuras mejoras de seguridad.

## Conclusion
La propuesta presenta una ruta metodologica y tecnica coherente para fortalecer la seguridad en arquitecturas cliente-servidor mediante un laboratorio local virtualizado. La integracion de politicas formales, controles implementados y simulaciones de validacion permite demostrar, con rigor academico, la mejora de la postura de seguridad del entorno analizado y la pertinencia del enfoque para fines de investigacion aplicada.
