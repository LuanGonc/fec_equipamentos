class Loan < ApplicationRecord
  belongs_to :equipment
  belongs_to :collaborator

    enum loan_action: {
    emprestimo: "emprestimo",
    devolucao: "devolucao",
    baixa: "baixa"
  }

  validates :loan_action, :equipment_id, :collaborator_id, presence: true
  validates :loan_action, inclusion: { in: loan_actions.keys }

  validate :validate_by_action #chama método para validação personalizada para cada tipo de ação


  after_create :update_status


  private 

  def validate_by_action
    case loan_action
    when "emprestimo"
      if loan_date.blank?
        errors.add(:loan_date, "não pode ficar em branco")
      end

    when "devolucao" 
      if return_date.blank?
        errors.add(:return_date, "não pode ficar em branco")
      end
      if return_reason.blank?
        errors.add(:return_reason, "não pode ficar em branco")
      end

    when "baixa"
      if discard_date.blank?
        errors.add(:discard_date, "não pode ficar em branco")
      end
      if discard_reason.blank?
        errors.add(:discard_date, "não pode ficae em branco")
      end
    end
  end

  def update_status 
    case loan_action
    when "emprestimo"
      equipment.update(status: "emprestado")

    when "devolucao"
      equipment.update(status: "disponivel")
    
    when "baixa"
      equipment.update(status: "indisponivel")
    end
  end
end
