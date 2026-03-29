# 05. Analisis de Riesgos

## 1. Metodologia
Se utiliza una matriz cualitativa con escalas:
1. Probabilidad: Baja (1), Media (2), Alta (3).
2. Impacto: Bajo (1), Medio (2), Alto (3).
3. Nivel de riesgo: Probabilidad x Impacto.

Interpretacion:
1. 1-2: Bajo
2. 3-4: Medio
3. 6-9: Alto

## 2. Activos Criticos
1. Credenciales de usuarios.
2. Datos compartidos en servidor.
3. Configuraciones de seguridad del sistema.
4. Registros de auditoria.
5. Scripts y respaldos.

## 3. Matriz de Riesgos
| ID | Riesgo | Probabilidad | Impacto | Nivel | Tratamiento principal |
|---|---|---:|---:|---:|---|
| R1 | Acceso no autorizado por credenciales comprometidas | 3 | 3 | 9 | Politica de acceso, bloqueo y auditoria |
| R2 | Fuerza bruta sobre SSH | 3 | 2 | 6 | Endurecimiento SSH, bloqueo por intentos, firewall |
| R3 | Escalacion de privilegios por permisos excesivos | 2 | 3 | 6 | Minimo privilegio, revision de grupos y sudo |
| R4 | Perdida de informacion por borrado accidental/malicioso | 2 | 3 | 6 | Respaldo programado y prueba de restauracion |
| R5 | Intercepcion de trafico no cifrado | 2 | 3 | 6 | Cifrado en transito con SSH/HTTPS |
| R6 | Vulnerabilidades por falta de parches | 3 | 3 | 9 | Politica de actualizacion y ventana de mantenimiento |
| R7 | Falta de trazabilidad por logs insuficientes | 2 | 2 | 4 | Politica de monitoreo y auditoria |
| R8 | Error humano en configuraciones criticas | 3 | 2 | 6 | Estandarizacion por scripts y checklist |
| R9 | Uso indebido de recursos por usuarios internos | 2 | 2 | 4 | Politica de uso aceptable y sanciones |
| R10 | Alteracion de archivos de configuracion | 2 | 3 | 6 | Control de permisos, auditoria y hardening |

## 4. Priorizacion
Los riesgos prioritarios para mitigacion temprana son R1, R2, R4, R5 y R6 por su potencial de comprometer confidencialidad, integridad y disponibilidad.
