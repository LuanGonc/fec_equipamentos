class Equipment < ApplicationRecord
    enum status: {
    disponível: "disponível",
    emprestado: "emprestado",
    indisponível: "indisponível"
  }

  # Validações de presença (campos obrigatórios)
  validates :brand, :model, :patrimony_number, :serial_number, :identifier, :purchase_date, :status, presence: true

  # Validações de unicidade
  validates :patrimony_number, :serial_number, :identifier, uniqueness: true

  # Validação de inclusão (para garantir apenas os 3 status permitidos)
  validates :status, inclusion: { in: statuses.keys }

  # Validação de formato (exemplo básico, pode ajustar)
  #validates :identifier, format: { with: /\A[A-Z0-9\-]+\z/,
   #                                message: "só pode conter letras maiúsculas, números e hífen" }
end
