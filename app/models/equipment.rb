class Equipment < ApplicationRecord
  has_many :loans, dependent: :destroy

    def self.ransackable_attributes(auth_object = nil)
      ["brand", "created_at", "identifier", "model", "patrimony_number", "purchase_date", "status"]
  end


    enum status: {
    disponivel: "Disponível",
    emprestado: "Emprestado",
    indisponivel: "Indisponível"
  }

  
  validates :brand, :model, :patrimony_number, :serial_number, :identifier, :purchase_date, :status, presence: true


  validates :patrimony_number, :serial_number, :identifier, uniqueness: true

  
  validates :status, inclusion: { in: statuses.keys }

  # Validação de formato (exemplo básico, pode ajustar)
  #validates :identifier, format: { with: /\A[A-Z0-9\-]+\z/,
   #                                message: "só pode conter letras maiúsculas, números e hífen" }
end
