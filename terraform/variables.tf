variable "project_id" {
  description = "ID do projeto do Google Cloud"
  type        = string
  default     = "trabalho-pratico-iac"
}

variable "region" {
  description = "A região onde os recursos serão provisionados"
  default     = "us-central1"
}

variable "zone" {
  description = "A zona onde as instâncias serão provisionadas"
  default     = "us-central1-c"
}

variable "vm_name" {
  description = "Nome da instância do servidor web (Nginx)"
  type        = string
  default     = "nginx-server"
}

variable "machine_type" {
  description = "Tipo de máquina para a instância do servidor web"
  default     = "f1-micro"
}

variable "image" {
  description = "Imagem para a instância do servidor web"
  default     = "projects/ubuntu-os-cloud/global/images/ubuntu-2410-oracular-amd64-v20250213"
}

variable "disk_size" {
  description = "Tamanho do disco (GB) para a instância do servidor web"
  default     = 10
}

variable "disk_type" {
  description = "Tipo de disco para a instância do servidor web"
  default     = "pd-balanced"
}

# (Desativado: substituído por startup.sh)
# variable "instalacao_nginx" {
#   description = "Instalacao do Nginx"
#   default     = "sudo apt-get update; sudo apt-get install -y sqlite3; sudo apt-get install -y nginx; sudo systemctl start nginx; sudo systemctl enable nginx"
# }

variable "startup_script_path" {
  description = "Caminho opcional para script de inicialização"
  type        = string
  default     = ""
}
