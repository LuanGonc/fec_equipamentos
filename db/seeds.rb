# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



Collaborator.create!(
    name: "Luisa",
    email: "Luisa@fec.com",
    department: "Operações"
)
Collaborator.create!(
    name: "Luan",
    email: "Luan@fec.com",
    department: "Desenvolvimento"
)
Collaborator.create!(
    name: "Marcos",
    email: "marcos@fec.com",
    department: "Recursos Humanos"
)
Collaborator.create!(
    name: "Rafael",
    email: "rafael@fec.com",
    department: "Desenvolvimento"
)
Collaborator.create!(
    name: "Jonas",
    email: "Luan@fec.com",
    department: "Recursos Humanos"
)
Collaborator.create!(
    name: "Maria",
    email: "maria@fec.com",
    department: "Operacoes"
)

#preenchimento dos campos feito por IA

Equipment.create!(
  brand: "Dell",
  model: "XPS 15",
  patrimony_number: "DLL001",
  serial_number: "SN-XPS15-001",
  identifier: "DELL-XPS-001",
  purchase_date: "2024-01-10",
  manufacture_date: "2023-12-01",
  description: "Notebook Dell XPS 15, 16GB RAM, SSD 512GB",
  status: "Disponível"
)

Equipment.create!(
  brand: "Apple",
  model: "MacBook Pro M2",
  patrimony_number: "APL001",
  serial_number: "SN-MBP-M2-001",
  identifier: "APPLE-MBP-001",
  purchase_date: "2024-02-15",
  manufacture_date: "2024-01-20",
  description: "MacBook Pro 14'' com chip M2, 16GB RAM, 1TB SSD",
  status: "Disponível"
)

# Equipamentos emprestados
Equipment.create!(
  brand: "Lenovo",
  model: "ThinkPad T490",
  patrimony_number: "LNV001",
  serial_number: "SN-T490-001",
  identifier: "LENOVO-T490-001",
  purchase_date: "2023-11-05",
  manufacture_date: "2023-09-10",
  description: "Notebook Lenovo ThinkPad T490, 8GB RAM, SSD 256GB",
  status: "Disponível"
)

Equipment.create!(
  brand: "HP",
  model: "EliteBook 840",
  patrimony_number: "HP001",
  serial_number: "SN-840-001",
  identifier: "HP-840-001",
  purchase_date: "2024-03-20",
  manufacture_date: "2024-02-01",
  description: "Notebook HP EliteBook 840, 16GB RAM, SSD 512GB",
  status: "Disponível"
)

# Equipamentos indisponíveis
Equipment.create!(
  brand: "Asus",
  model: "ZenBook 14",
  patrimony_number: "ASU001",
  serial_number: "SN-ZB14-001",
  identifier: "ASUS-ZB14-001",
  purchase_date: "2023-10-12",
  manufacture_date: "2023-08-15",
  description: "Notebook Asus ZenBook 14, 12GB RAM, SSD 256GB",
  status: "Disponível"
)

Equipment.create!(
  brand: "Acer",
  model: "Swift 3",
  patrimony_number: "ACR001",
  serial_number: "SN-SW3-001",
  identifier: "ACER-SW3-001",
  purchase_date: "2024-04-05",
  manufacture_date: "2024-03-01",
  description: "Notebook Acer Swift 3, 8GB RAM, SSD 512GB",
  status: "Disponível"
)

# Equipamento com configuração avançada
Equipment.create!(
  brand: "Microsoft",
  model: "Surface Laptop 5",
  patrimony_number: "MSF001",
  serial_number: "SN-SL5-001",
  identifier: "MS-SL5-001",
  purchase_date: "2024-05-01",
  manufacture_date: "2024-04-10",
  description: "Surface Laptop 5, 32GB RAM, 1TB SSD, Touchscreen",
  status: "Disponível"
)

# Equipamento mais antigo
Equipment.create!(
  brand: "Dell",
  model: "Latitude E7440",
  patrimony_number: "DLL002",
  serial_number: "SN-E7440-001",
  identifier: "DELL-LAT-001",
  purchase_date: "2018-06-15",
  manufacture_date: "2018-04-20",
  description: "Notebook Dell Latitude E7440, 8GB RAM, HDD 500GB",
  status: "Disponível"
)
