# Home-Hap

# Neste projeto vamos:

 - Configurar um ambiente no Google Cloud utilizando o Terraform.
 - Criar uma instância de VM no Google Cloud (GCE) com o Home Assistant instalado em container Docker.
 - Utilizar Ansible para configurar automaticamente o ambiente da VM (instalação do Docker, Docker Compose, Home Assistant e Nginx).
 - Definir regras de firewall para permitir tráfego HTTP (porta 80), HTTPS (porta 443) e Home Assistant (porta 8123).
 - Usar Nginx como proxy reverso para expor o Home Assistant com segurança na internet.
 - Integrar um domínio customizado com o Cloudflare para DNS e HTTPS.

---

## Estrutura de Pastas do Projeto

A estrutura de pastas foi projetada para manter o código organizado, modular e fácil de manter conforme o projeto cresce. A seguir, a estrutura de diretórios utilizada:

```bash
home-hap/
├── ansible/                           # Configuração pós-provisionamento (Ansible)
│   ├── inventory.ini                  # (Será gerado automaticamente) Contém IP e SSH para acessar a VM
│   ├── playbook.yml                   # Playbook principal que executa todas as tarefas de configuração
│   └── roles/
│       └── home_assistant/            # Role dedicada à instalação e configuração do Home Assistant
│           └── tasks/
│               └── main.yml           # Tarefas do Ansible para instalar Docker, Home Assistant e Nginx
├── docs/                              # Arquivos Terraform para provisionamento da infraestrutura na GCP
│   ├── steps                          # Passo a passo completo para execução do projeto (Terraform + Ansible)
│   └── diagrams                       # Diagramas visuais da arquitetura do projeto
├── terraform/                         # Arquivos Terraform para provisionamento da infraestrutura na GCP
│   ├── main.tf                        # Define os recursos principais (VM, IP, firewall, etc.)
│   ├── variables.tf                   # Declaração de variáveis utilizadas no projeto
│   ├── outputs.tf                     # Exibe IP, nome e zona da VM após criação
│   └── startup.sh                     # Script de inicialização da VM com Docker, HA, Nginx e Mosquitto
├── README.md                          # Arquivo de instruções e documentação principal do projeto
```
## Instalar o Terraform

### Linux (Ubuntu/Debian)

```bash
sudo apt update && sudo apt install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

### Verificar a instalação

```bash
terraform version
```

---

## Autenticação no Google Cloud

O Terraform precisa acessar sua conta do Google Cloud. Para isso, você precisa gerar uma chave de serviço.

### Acesse o Console do Google Cloud

1. Vá para **IAM e Admin > Contas de serviço**.
2. Crie uma nova conta de serviço com as permissões **Editor** e **Admin do Compute Engine**.
3. Baixe a chave JSON e salve em um local seguro (ex: `~/gcp-key.json`).

---

## Configure as credenciais no Terraform

### No terminal, defina a variável de ambiente:

```bash
export GOOGLE_APPLICATION_CREDENTIALS="~/gcp-key.json"
```

---

## Executar o Terraform

```bash
terraform init
terraform apply
```

---

## Após o provisionamento da VM

1. Acesse a pasta `ansible/` do projeto.
2. Edite o arquivo `inventory.ini` com o IP da VM gerada:

```ini
[gcp]
IP_DA_VM ansible_user=USUARIO ansible_ssh_private_key_file=~/.ssh/id_rsa
```

3. Execute o playbook Ansible:

```bash
ansible-playbook -i inventory.ini playbook.yml
```

O Ansible irá:

- Instalar Docker e Docker Compose
- Configurar o container do Home Assistant
- Instalar e configurar o Nginx como proxy reverso
- Aplicar HTTPS ao domínio via Certbot ou integração Cloudflare

---

## Acesso ao Home Assistant

Após o provisionamento e configuração, acesse:

```
https://home.seudominio.com
```

---

## Observações

- Os recursos criados na nuvem podem gerar custos. Após a apresentação, lembre-se de destruir a infraestrutura com:

```bash
terraform destroy
```

- Para maior segurança, utilize autenticação em duas etapas no Cloudflare e no Home Assistant.

---

## Licença

MIT

# 🛠️ Execução Final do Projeto Home-Hap

Este guia descreve como executar o projeto **Home-Hap** do início ao fim, utilizando **Terraform + Ansible**, de forma totalmente automatizada.

---

## ✅ Pré-requisitos

- Conta na **Google Cloud Platform** com faturamento ativado
- Projeto criado no GCP com Compute Engine habilitado
- Chave de serviço salva localmente (ex: `~/gcp-key.json`)
- Variável de ambiente configurada:
  ```bash
  export GOOGLE_APPLICATION_CREDENTIALS="~/gcp-key.json"
  ```
- Chave SSH gerada (`~/.ssh/id_rsa`) e autorizada no GCP
- Programas instalados:
  - Terraform
  - Ansible

---

## 🚀 Passo a Passo

### 1. Acesse o projeto

```bash
cd ~/seu-caminho/home-hap
```

---

### 2. Provisione a infraestrutura com Terraform

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

---

### 3. Gere o arquivo de inventário do Ansible

```bash
cd ../ansible
./gen_inventory.sh
```

> Isso criará o arquivo `inventory.ini` com o IP da VM e as informações de acesso via SSH.

---

### 4. Execute o Ansible para configurar a VM

```bash
ansible-playbook -i inventory.ini playbook.yml
```

---

## 🌐 Resultado Esperado

Ao final da execução, o Home Assistant estará disponível em:

```bash
http://<IP_EXTERNO_DA_VM>
```

Se você configurar um domínio e HTTPS via Nginx + Certbot ou Cloudflare, o endereço será:

```bash
https://home.seudominio.com
```

---

## 🧽 Para destruir a infraestrutura

Quando quiser remover os recursos criados na nuvem:

```bash
cd terraform
terraform destroy -auto-approve
```

---

## 📂 Estrutura Relevante

- `terraform/startup.sh`: Instalação manual automatizada (opcional)
- `ansible/playbook.yml`: Playbook principal do Ansible
- `ansible/roles/home_assistant/tasks/main.yml`: Tarefas de instalação e configuração

---

## 🏁 Fim!

Você agora tem um ambiente completo de automação residencial com Home Assistant rodando na nuvem, de forma automatizada e reprodutível! 👏
