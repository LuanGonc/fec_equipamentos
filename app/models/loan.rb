class Loan < ApplicationRecord
  belongs_to :equipment
  belongs_to :collaborator

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      loan_action loan_date return_date return_reason
      discard_date discard_reason created_at updated_at
      equipment_id collaborator_id
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[collaborator equipment]
  end

  enum loan_action: {
    emprestimo: 'emprestimo',
    devolucao: 'devolucao',
    baixa: 'baixa'
  }

  validates :loan_action, :equipment_id, :collaborator_id, presence: true
  validates :loan_action, inclusion: { in: loan_actions.keys }
  validate :validate_by_action 

  after_create :update_status

  private

  def validate_by_action
    case loan_action
    when 'emprestimo'
      errors.add(:loan_date, 'não pode ficar em branco') if loan_date.blank?

    when 'devolucao'
      errors.add(:return_date, 'não pode ficar em branco') if return_date.blank?
      errors.add(:return_reason, 'não pode ficar em branco') if return_reason.blank?

    when 'baixa'
      errors.add(:discard_date, 'não pode ficar em branco') if discard_date.blank?
      errors.add(:discard_reason, 'não pode ficar em branco') if discard_reason.blank?
    end
  end

  def update_status
    case loan_action
    when 'emprestimo'
      equipment.update(status: 'emprestado')

    when 'devolucao'
      equipment.update(status: 'disponivel')

    when 'baixa'
      equipment.update(status: 'indisponivel')
    end
  end

end
