Projeto Vagrant com Zabbix e MySQL

Este projeto utiliza Vagrant para provisionar uma máquina virtual Ubuntu 22.04 com o Zabbix Server e MySQL instalados automaticamente.

📌 Requisitos

Antes de iniciar, certifique-se de ter instalado em seu sistema:

VirtualBox

Vagrant

🚀 Configuração do Ambiente

1️⃣ Clonar o Repositório

 git clone https://github.com/seu-repositorio/vagrant-zabbix.git
 cd vagrant-zabbix

2️⃣ Iniciar a Máquina Virtual

 vagrant up

Isso iniciará a VM, instalará os pacotes necessários e configurará o Zabbix automaticamente.

3️⃣ Acessar a VM

 vagrant ssh

📡 Acesso ao Zabbix

Após a instalação, o Zabbix Web Interface estará disponível em:

http://192.168.56.10/

🔑 Credenciais padrão:Usuário: AdminSenha: zabbix

📜 Configuração no Vagrantfile

O Vagrantfile contém as seguintes configurações:

Box: ubuntu/jammy64

Memória: 1024 MB

CPUs: 2

Rede privada: IP 192.168.56.10

Provisionamento via script: scripts/mysql-zabbix-install.sh

🔧 Provisionamento - Script mysql-zabbix-install.sh

O script executado automaticamente faz:

Atualização do sistema.

Instalação do MySQL Server e criação do banco de dados zabbix.

Instalação do Zabbix Server, Agent, Frontend (Nginx e PHP).

Importação do esquema de banco de dados do Zabbix.

Configuração do zabbix_server.conf.

Ajustes no Nginx e PHP.

Reinicialização e ativação dos serviços necessários.

🛠️ Comandos Úteis

🔄 Recarregar a VM:

 vagrant reload --provision

🛑 Parar a VM:

 vagrant halt

❌ Destruir a VM:

 vagrant destroy -f

📝 Observações

Certifique-se de que o VirtualBox e o Vagrant estejam atualizados.

Se houver problemas com a VM, tente executar vagrant destroy -f seguido de vagrant up novamente.