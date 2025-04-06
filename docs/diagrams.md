# 📊 Diagramas do Projeto Home-Hap

Este documento contém representações gráficas da arquitetura e fluxo de execução do projeto **Home-Hap**, utilizando a linguagem **Mermaid** compatível com GitHub.

---

## 🧭 Arquitetura da Infraestrutura Home-Hap

```mermaid
graph TD
  User[Usuario] -->|Acessa| Domain[home.seudominio.com]
  Domain --> Cloudflare[Cloudflare DNS]
  Cloudflare -->|Resolve IP| GCP[Google Cloud]
  GCP --> VM[GCE Ubuntu]
  VM --> Nginx[Nginx Proxy]
  Nginx --> HA[Home Assistant Container]
  VM --> Mosquitto[Mosquitto MQTT Broker]
```

---

## 🧩 Visão Geral do Projeto Home-Hap

```mermaid
flowchart TD
  TF[Terraform] -->|Provisiona| GCP[Google Cloud VM]
  GCP -->|IP Externo| DNS[Cloudflare DNS]
  GCP --> Ansible[Ansible]
  Ansible --> Docker[Docker + Compose]
  Docker --> HA[Home Assistant]
  Docker --> MQTT[Mosquitto Broker]
  Ansible --> Nginx[Nginx Proxy]
  Nginx -->|Reverso| HA
```
