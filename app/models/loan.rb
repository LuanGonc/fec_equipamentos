class Loan < ApplicationRecord
  belongs_to :equipment
  belongs_to :collaborator

    enum action_type: {
    emprestimo: "emprestimo",
    devolucao: "devolucao",
    baixa: "baixa"
  }

  validates: :action, :equipment_id, :collaborator_id, presence: true


  validate :validate_by_action #chama método para validação personalizada para cada tipo de ação

  private 

  def validate_by_action
    case action
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
