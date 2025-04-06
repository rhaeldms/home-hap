#!/bin/bash

# Caminho do arquivo inventory.ini
INVENTORY_FILE="inventory.ini"

# Obtém IP da VM via Terraform
IP=$(terraform -chdir=../terraform output -raw external_ip)

# Tenta descobrir o usuário padrão da imagem da VM
USER="ubuntu"

# Caminho da chave SSH padrão do GCP
KEY_PATH="$HOME/.ssh/id_rsa"

# Gera o arquivo inventory.ini
cat <<EOF > "$INVENTORY_FILE"
[gcp]
$IP ansible_user=$USER ansible_ssh_private_key_file=$KEY_PATH
EOF

echo "Arquivo $INVENTORY_FILE gerado com sucesso:"
cat "$INVENTORY_FILE"
