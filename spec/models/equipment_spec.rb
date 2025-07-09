require 'rails_helper'

RSpec.describe Equipment, type: :model do
  it "é válido com todos os atributos obrigatórios" do
    equipment = Equipment.new(
      brand: "Dell",
      model: "Inspiron",
      patrimony_number: "12345",
      serial_number: "SN001",
      identifier: "EQ001",
      purchase_date: Date.today,
      status: "disponivel"
    )

    expect(equipment).to be_valid
  end


  ##Testes de Presence (não pode ficar em branco)
        #atributos: brand, model, patrimony_number, serial_number, identifier, purchase_date, status

    it "é inválido sem marca (brand)" do
        equipment = Equipment.new(brand: nil)
        equipment.validate
        expect(equipment.errors[:brand]).to include("não pode ficar em branco")
    end

    it "é inválido sem modelo (model)" do
        equipment = Equipment.new(model: nil)
        equipment.validate
        expect(equipment.errors[:model]).to include("não pode ficar em branco")
    end

    it "é inválido sem número de patrimonio (patrimony_number)" do
        equipment = Equipment.new(patrimony_number: nil)
        equipment.validate
        expect(equipment.errors[:patrimony_number]).to include("não pode ficar em branco")
    end

    it "é inválido sem número de série (serial_number)" do
        equipment = Equipment.new(serial_number: nil)
        equipment.validate
        expect(equipment.errors[:serial_number]).to include("não pode ficar em branco")
    end

    it "é inválido sem indentificador (identifier)" do
        equipment = Equipment.new(identifier: nil)
        equipment.validate
        expect(equipment.errors[:identifier]).to include("não pode ficar em branco")
    end

    it "é inválido sem data de compra (purchase_date)" do
        equipment = Equipment.new(purchase_date: nil)
        equipment.validate
        expect(equipment.errors[:purchase_date]).to include("não pode ficar em branco")
    end    

    it "é inválido sem status" do
        equipment = Equipment.new(status: nil)
        equipment.validate
        expect(equipment.errors[:status]).to include("não pode ficar em branco")
    end      

end