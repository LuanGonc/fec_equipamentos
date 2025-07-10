require 'rails_helper'

RSpec.describe Loan, type: :model do
  subject { build(:loan) }

  # Teste básico
    it "é válido com todos os atributos obrigatórios para empréstimo" do
        equipment = create(:equipment)
        collaborator = create(:collaborator)

        loan = build(:loan, loan_action: "emprestimo", loan_date: Date.today, equipment: equipment, collaborator: collaborator)
        expect(loan).to be_valid
    end 


  # validação de presença sempre obrigatória
  it { should validate_presence_of(:loan_action) }
  it { should validate_presence_of(:equipment_id) }
  it { should validate_presence_of(:collaborator_id) }



  # testes de validação condicional
  context "quando é um empréstimo" do
    subject { build(:loan, loan_action: "emprestimo", loan_date: nil) }

    it "não é válido sem loan_date" do
      expect(subject).to_not be_valid
      expect(subject.errors[:loan_date]).to include("Não pode ficar em branco")
    end
  end

  context "quando é uma devolução" do
    subject { build(:loan, loan_action: "devolucao", return_date: nil, return_reason: nil) }

    it "não é válido sem return_date e return_reason" do
      expect(subject).to_not be_valid
      expect(subject.errors[:return_date]).to include("Não pode ficar em branco")
      expect(subject.errors[:return_reason]).to include("Não pode ficar em branco")
    end
  end

  context "quando é uma baixa" do
    subject { build(:loan, loan_action: "baixa", discard_date: nil, discard_reason: nil) }

    it "não é válido sem discard_date e discard_reason" do
      expect(subject).to_not be_valid
      expect(subject.errors[:discard_date]).to include("Não pode ficar em branco")
      expect(subject.errors[:discard_reason]).to include("Não pode ficar em branco")
    end
  end


    # associações
  it { should belong_to(:equipment) }
  it { should belong_to(:collaborator) }

end