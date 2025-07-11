class Equipment < ApplicationRecord
  has_many :loans, dependent: :destroy
  before_validation :normalize_fields
  has_one_attached :invoice_pdf
  after_initialize :set_default_status, if: :new_record?

  def self.ransackable_attributes(_auth_object = nil)
    %w[brand created_at identifier model patrimony_number purchase_date status]
  end

  enum status: {
    disponivel: 'Disponível',
    emprestado: 'Emprestado',
    indisponivel: 'Indisponível'
  }

  validates :brand, :model, :patrimony_number, :serial_number, :identifier, :purchase_date, :status, presence: true

  validates :patrimony_number, :serial_number, :identifier, uniqueness: { case_sensitive: false }

  validates :status, inclusion: { in: statuses.keys }

  

  private
  def set_default_status
    self.status ||= 'Disponível'
  end

  def normalize_fields
    self.brand = brand.strip.upcase if brand.present?
    self.model = model.strip.upcase if model.present?
    self.patrimony_number = patrimony_number.strip.upcase if patrimony_number.present?
    self.serial_number = serial_number.strip.upcase if serial_number.present?
    self.identifier = identifier.strip.upcase if identifier.present?
  end
end
