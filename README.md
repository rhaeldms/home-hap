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
├── terraform/                         # Arquivos Terraform para provisionamento da infraestrutura na GCP
│   ├── main.tf                        # Define os recursos principais (VM, IP, firewall, etc.)
│   ├── variables.tf                   # Declaração de variáveis utilizadas no projeto
│   ├── outputs.tf                     # Exporta informações úteis (como IP externo da VM)
├── README.md                          # Arquivo de instruções e documentação principal do projeto
```
