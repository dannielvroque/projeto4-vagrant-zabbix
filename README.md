# Projeto: Vagrant + Zabbix Server

Este projeto utiliza Vagrant para provisionar uma máquina virtual Ubuntu 22.04 (Jammy) com o Zabbix Server e MySQL pré-configurados.

## Pré-requisitos

Certifique-se de ter os seguintes softwares instalados:
- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)

## Configuração da Máquina Virtual

O Vagrantfile define uma máquina virtual com as seguintes configurações:
- **Sistema operacional:** Ubuntu 22.04 (jammy64)
- **Memória:** 1024MB
- **CPUs:** 2
- **IP privado:** 192.168.56.10
- **Provisionamento:** Script shell para instalação do MySQL e Zabbix

## Como Usar

1. Clone este repositório:
   ```sh
   git clone https://github.com/dannielvroque/projeto4-vagrant-zabbix.git
   cd seu-repositorio
   ```

2. Inicie a máquina virtual:
   ```sh
   vagrant up
   ```

3. Acesse a máquina virtual via SSH:
   ```sh
   vagrant ssh
   ```

## Serviços Instalados

### MySQL
- Banco de dados: `zabbix`
- Usuário: `zabbix`
- Senha: `teste123`

### Zabbix Server
- Instalado e configurado para conectar ao banco de dados MySQL

### Nginx + PHP
- Configurado para rodar a interface web do Zabbix
- **Acesso Web:** `http://192.168.56.10`

## Personalização

Caso precise alterar alguma configuração, edite:
- `Vagrantfile` para modificar os recursos da VM
- `scripts/mysql-zabbix-install.sh` para ajustes no provisionamento

## Parar e Remover a Máquina Virtual

Para desligar a VM:
```sh
vagrant halt
```

Para destruir a VM:
```sh
vagrant destroy -f
```

## Licença
Este projeto é distribuído sob a licença MIT.

