# Plataforma de virtualizacion local objetivo. No se usa nube publica.
variable "plataforma_virtualizacion" {
  description = "Plataforma local: libvirt, hyperv o virtualbox"
  type        = string
  default     = "hyperv"

  validation {
    condition     = contains(["libvirt", "hyperv", "virtualbox"], var.plataforma_virtualizacion)
    error_message = "plataforma_virtualizacion debe ser libvirt, hyperv o virtualbox."
  }
}

# Variable requerida: nombre del proyecto.
variable "project_name" {
  description = "Nombre del proyecto/laboratorio"
  type        = string
  default     = "proyecto-seguridad-cliente-servidor"
}

# Variables requeridas: red (nombre y CIDR).
variable "network_name" {
  description = "Nombre de la red interna del laboratorio"
  type        = string
  default     = "red-interna-lab"
}

variable "network_cidr" {
  description = "CIDR de la red interna simulada"
  type        = string
  default     = "192.168.56.0/24"
}

# Variables requeridas: nombre de servidor y clientes.
variable "server_name" {
  description = "Nombre de la VM servidor"
  type        = string
  default     = "srv-linux-seg"
}

variable "client_names" {
  description = "Nombres de las VMs cliente"
  type        = list(string)
  default     = ["cli-01", "cli-02"]
}

# Variables opcionales de direccionamiento para inventario/documentacion.
variable "server_ip" {
  description = "IP esperada de la VM servidor"
  type        = string
  default     = "192.168.56.10"
}

variable "client_ips" {
  description = "IPs esperadas para las VMs cliente"
  type        = list(string)
  default     = ["192.168.56.21", "192.168.56.22"]
}

# Variables requeridas: CPU, memoria y disco del servidor.
variable "server_cpu" {
  description = "vCPU asignadas al servidor"
  type        = number
  default     = 2
}

variable "server_memory_mb" {
  description = "Memoria del servidor en MB"
  type        = number
  default     = 4096
}

variable "server_disk_gb" {
  description = "Disco del servidor en GB"
  type        = number
  default     = 40
}

# Variables requeridas: CPU, memoria y disco de clientes.
variable "client_cpu" {
  description = "vCPU por cada cliente"
  type        = number
  default     = 2
}

variable "client_memory_mb" {
  description = "Memoria en MB por cada cliente"
  type        = number
  default     = 4096
}

variable "client_disk_gb" {
  description = "Disco en GB por cada cliente"
  type        = number
  default     = 50
}

# Datos del sistema operativo para referencia de plantilla.
variable "server_os" {
  description = "SO objetivo del servidor"
  type        = string
  default     = "ubuntu-22.04"
}

variable "client_os" {
  description = "SO objetivo de clientes"
  type        = string
  default     = "windows-11"
}
