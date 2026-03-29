output "plataforma_virtualizacion" {
  description = "Plataforma seleccionada"
  value       = var.plataforma_virtualizacion
}

output "project_name" {
  description = "Nombre del proyecto"
  value       = var.project_name
}

output "network" {
  description = "Configuracion de red del laboratorio"
  value = {
    name = var.network_name
    cidr = var.network_cidr
  }
}

output "vm_inventory" {
  description = "Inventario logico del laboratorio"
  value       = local.vm_inventory
}

output "server_profile" {
  description = "Perfil de recursos del servidor"
  value = {
    name      = var.server_name
    cpu       = var.server_cpu
    memory_mb = var.server_memory_mb
    disk_gb   = var.server_disk_gb
  }
}

output "clients_profile" {
  description = "Perfiles de recursos de clientes"
  value = {
    names     = var.client_names
    cpu       = var.client_cpu
    memory_mb = var.client_memory_mb
    disk_gb   = var.client_disk_gb
  }
}

output "inventory_file" {
  description = "Ruta del inventario generado"
  value       = local_file.inventory.filename
}
