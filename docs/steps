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
