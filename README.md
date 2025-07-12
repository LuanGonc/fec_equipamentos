# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

--------
rvm install 3.2.3
rvm use 3.2.3

gem install rails -v 7.1.5.1
bundle install


sudo apt install -y postgresql postgresql-contrib libpq-dev
sudo service postgresql start
sudo service postgresql status

# Mudar para o usuário padrão "postgres"
sudo -u postgres psql

sudo nano /etc/postgresql/*/main/pg_hba.conf

# "local" is for Unix domain socket connections only
local   all             all                                     md5

sudo service postgresql restart


testar: 
# Conectar com o usuário criado
psql -U fec_user -d fec_equipamentos_development -h localhost
# Digite a senha quando solicitado
Verifique se você entra no prompt: fec_equipamentos_development=>
rails db:create
rails db:migrate
rails db:seed