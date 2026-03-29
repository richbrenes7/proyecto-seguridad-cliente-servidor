# 11. Propuesta Academica Formal

## Titulo Propuesto
Diseno e implementacion de politicas de seguridad informatica para una arquitectura cliente-servidor en laboratorio local virtualizado.

## Resumen
La presente propuesta desarrolla un marco metodologico para el diseno, implementacion y validacion de politicas de seguridad informatica en una arquitectura cliente-servidor desplegada en laboratorio local. El estudio aborda amenazas recurrentes, entre ellas acceso no autorizado, fuerza bruta, perdida de informacion, errores de configuracion y ausencia de trazabilidad. La estrategia integra analisis de riesgos, formulacion normativa, controles tecnicos y simulaciones controladas, con el fin de generar evidencia verificable sobre la eficacia de las medidas aplicadas.

## Introduccion
La seguridad de las arquitecturas cliente-servidor exige una aproximacion sistematica que articule componentes organizacionales y tecnicos. En ausencia de politicas formales, las configuraciones por defecto y las practicas no estandarizadas incrementan la probabilidad de incidentes que comprometen los principios de confidencialidad, integridad y disponibilidad.

En este contexto, la propuesta se orienta a construir un laboratorio academico reproducible, sin uso de contenedores y basado en maquinas virtuales, para validar controles de seguridad mediante procedimientos observables y defendibles.

## Planteamiento del Problema
En entornos de laboratorio es frecuente la implementacion de infraestructura cliente-servidor sin una relacion explicita entre riesgos, politicas, controles y evidencia. Ello genera debilidades en autenticacion, autorizacion, proteccion de datos, monitoreo y respuesta ante incidentes, limitando la capacidad de prevenir, detectar y corregir eventos de seguridad.

La investigacion se centra en resolver dicha brecha mediante un modelo integrado de gestion de seguridad aplicable a un entorno local simulado.

## Justificacion
1. Relevancia academica: integra fundamentos teoricos de seguridad con validacion practica en un proyecto de posgrado.
2. Relevancia tecnica: demuestra la aplicabilidad de controles base sobre amenazas frecuentes en arquitecturas cliente-servidor.
3. Viabilidad operativa: se ejecuta en laboratorio local con herramientas accesibles y costo controlado.

## Hipotesis de Trabajo
La implementacion coordinada de politicas de seguridad y controles tecnicos en un laboratorio cliente-servidor reduce de forma medible la exposicion a riesgos operativos y de ciberseguridad.

## Objetivo General
Disenar, implementar y validar un conjunto de politicas de seguridad informatica aplicadas a una arquitectura cliente-servidor en laboratorio local virtualizado, con la finalidad de fortalecer la postura de seguridad del entorno.

## Objetivos Especificos
1. Identificar activos criticos y vectores de amenaza del entorno.
2. Evaluar riesgos mediante una matriz cualitativa.
3. Formular politicas de seguridad con criterios de cumplimiento y medidas correctivas.
4. Implementar controles tecnicos en servidor y clientes.
5. Ejecutar simulaciones para validar la eficacia de los controles.
6. Documentar resultados y recomendaciones con rigor academico.

## Metodologia
1. Identificacion de activos y amenazas.
2. Valoracion cualitativa de riesgos.
3. Diseno de politicas de seguridad.
4. Implementacion tecnica en servidor y clientes.
5. Simulaciones de validacion con evidencia.
6. Analisis de resultados y recomendaciones.

## Alcance
1. Laboratorio local sin contenedores.
2. Arquitectura minima de un servidor Linux y dos clientes.
3. Red interna simulada para pruebas controladas.
4. Implementacion de controles sobre acceso, usuarios, datos, parcheo, monitoreo y respuesta.

## Limitaciones
1. Los resultados no equivalen a certificacion de entornos productivos.
2. La capacidad del host condiciona la complejidad de escenarios.
3. El aprovisionamiento con Terraform depende del provider local disponible.

## Aporte Esperado
1. Marco reutilizable para laboratorios academicos de ciberseguridad.
2. Plantillas de politicas y trazabilidad riesgo-control.
3. Base para evolucionar a entornos de mayor complejidad.

## Resultados Esperados
1. Politicas formalizadas e implementadas con evidencia de cumplimiento.
2. Reduccion observable de riesgos priorizados.
3. Mejora de trazabilidad en eventos de seguridad.
4. Reproducibilidad del laboratorio para fines docentes y de investigacion.

## Consideraciones Eticas
1. Todas las pruebas se ejecutan en entorno aislado y autorizado.
2. No se realizan ataques sobre infraestructuras externas.
3. Se protege la confidencialidad de credenciales y evidencias.

## Conclusiones Preliminares
La propuesta ofrece un enfoque metodologico coherente para fortalecer la seguridad en arquitecturas cliente-servidor mediante politicas formales y controles tecnicos validados en laboratorio local. Su principal fortaleza radica en la articulacion entre analisis de riesgos, implementacion operativa y evidencia empirica, lo cual sustenta su defendibilidad academica.
