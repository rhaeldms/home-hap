terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

#############################
# Instância do Servidor Web #
#############################

resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    auto_delete = true
    mode        = "READ_WRITE"
    initialize_params {
      image = var.image
      size  = var.disk_size
      type  = var.disk_type
    }
  }

  tags = ["http-server", "https-server", "home-assistant"]

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = var.instalacao_nginx
}

###################################
# Regras de Firewall para Nginx   #
###################################

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "allow_https" {
  name    = "allow-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}

####################################################
# Regra de Firewall para porta 8123 (Home Assistant)
####################################################

resource "google_compute_firewall" "allow_home_assistant" {
  name    = "allow-home-assistant"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8123"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["home-assistant"]
}

#############################
# Output com IP da instância
#############################

output "external_ip" {
  description = "IP externo da VM criada"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}
