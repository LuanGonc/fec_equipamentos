# Instruções para Configuração e Execução do Projeto

## Passo a Passo para Configuração

### 1. Instalar e Configurar Ruby e Rails


```bash
rvm install 3.2.3
rvm use 3.2.3

gem install rails -v 7.1.5.1
bundle install
```
### 2. Instalar e Configurar o PostgreSQL
```bash
sudo apt update
sudo apt install -y postgresql postgresql-contrib libpq-dev
sudo service postgresql start
sudo service postgresql status
```
### 3.Configurar Usuário e Permissões do Banco de Dados
```bash
sudo -u postgres psql -c "CREATE ROLE fec_user WITH LOGIN PASSWORD 'fec_password';"
```

### 4.Modificar a Política de Autenticação do PostgreSQL
```bash
sudo nano /etc/postgresql/*/main/pg_hba.conf
```
Localize a linha abaixo e altere peer para md5:
```
# "local" is for Unix domain socket connections only
local   all             all                                     md5
```
Após isso, reinicie o serviço do PostgreSQL:
```bash
sudo service postgresql restart
```
### 5.Testar a Conexão com o Banco de Dados
```bash
psql -U fec_user -d fec_equipamentos_development -h localhost
```
Quando solicitado, insira a senha: fec_password

Você deve ver o prompt:

fec_equipamentos_development=>


### 7. Criar e Popular o Banco de Dados
```bash
rails db:create
rails db:migrate
rails db:seed
```

#### 8. Iniciar o Servidor:
```bash
bin/dev
```
### 9. Acessar a Aplicação
http://localhost:3000