output "external_ip" {
  description = "IP externo da VM criada"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "instance_name" {
  description = "Nome da instância criada"
  value       = google_compute_instance.vm_instance.name
}

output "zone" {
  description = "Zona onde a instância foi provisionada"
  value       = google_compute_instance.vm_instance.zone
}
