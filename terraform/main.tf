terraform {
  required_version = ">= 1.5.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

locals {
  # Estructura logica del laboratorio para inventario y trazabilidad.
  server = {
    name      = var.server_name
    ip        = var.server_ip
    os        = var.server_os
    cpu       = var.server_cpu
    memory_mb = var.server_memory_mb
    disk_gb   = var.server_disk_gb
    role      = "servidor-linux"
  }

  clients = [
    for idx, name in var.client_names : {
      name      = name
      ip        = try(var.client_ips[idx], null)
      os        = var.client_os
      cpu       = var.client_cpu
      memory_mb = var.client_memory_mb
      disk_gb   = var.client_disk_gb
      role      = "cliente"
    }
  ]

  vm_inventory = {
    server  = local.server
    clients = local.clients
  }
}

# Plantilla base local: genera inventario, sin asumir proveedor especifico.
# Sirve aunque la creacion de VMs se complete luego con libvirt/Hyper-V/VirtualBox.
resource "local_file" "inventory" {
  filename = "${path.module}/inventory-lab.json"
  content  = jsonencode({
    project_name              = var.project_name
    plataforma_virtualizacion = var.plataforma_virtualizacion
    network = {
      name = var.network_name
      cidr = var.network_cidr
    }
    nodes = local.vm_inventory
  })
}

resource "null_resource" "validacion_basica" {
  triggers = {
    plataforma = var.plataforma_virtualizacion
    project    = var.project_name
    network    = var.network_name
  }
}

# ======================================================================
# BLOQUES DE REFERENCIA (COMENTADOS): ADAPTACION SEGUN PROVIDER LOCAL
# ======================================================================

# Libvirt (Linux host):
# provider "libvirt" {
#   uri = "qemu:///system"
# }
#
# resource "libvirt_network" "lab" {
#   name      = var.network_name
#   mode      = "nat"
#   addresses = [var.network_cidr]
# }

# Hyper-V (Windows host):
# provider "hyperv" {
#   # Ajustar con el proveedor elegido por tu entorno.
# }
#
# resource "hyperv_vhd" "server_disk" {
#   # Declarar disco del servidor con var.server_disk_gb
# }

# VirtualBox (multi-plataforma):
# provider "virtualbox" {
#   # Configuracion del proveedor segun plugin instalado
# }
#
# resource "virtualbox_vm" "server" {
#   # Declarar VM servidor con CPU/memoria/disco variables
# }
