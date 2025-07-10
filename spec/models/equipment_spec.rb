require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe Equipment, type: :model do
  subject { build(:equipment) }  # build não salva no banco

  # Teste de exemplo válido
  it "é válido com todos os atributos obrigatórios" do
    expect(subject).to be_valid
  end

  # Testes de presença
  it { should validate_presence_of(:brand) }
  it { should validate_presence_of(:model) }
  it { should validate_presence_of(:patrimony_number) }
  it { should validate_presence_of(:serial_number) }
  it { should validate_presence_of(:identifier) }
  it { should validate_presence_of(:purchase_date) }
  it { should validate_presence_of(:status) }

  # Testes de unicidade (com registro pré-existente)
  describe "validações de unicidade" do
    let!(:existing_equip) { create(:equipment) }  # create salva no banco

    it { should validate_uniqueness_of(:patrimony_number).case_insensitive }
    it { should validate_uniqueness_of(:serial_number).case_insensitive }
    it { should validate_uniqueness_of(:identifier).case_insensitive }
  end

  # Teste de associação
  it { should have_many(:loans).dependent(:destroy) }

end
