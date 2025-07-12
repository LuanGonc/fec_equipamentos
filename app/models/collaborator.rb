class Collaborator < ApplicationRecord
  has_many :loans, dependent: :destroy
  validates :name, :email, :department, presence: true
  before_validation :normalize_fields

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at department email id id_value name updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['loans']
  end

  validates :name, :email, :department, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validate :valid_email_format # Usando nossa validação personalizada

  private

  def normalize_fields
    self.name = name.strip.titleize if name.present?
    self.email = email.strip.downcase if email.present?
    self.department = department.strip.titleize if department.present?
  end

  def valid_email_format
    # Verifica se está em branco
    return if email.blank?

    return if URI::MailTo::EMAIL_REGEXP.match?(email) # regex do ruby para formato do email

    errors.add(:email, 'não é um formato válido')
    nil
  end
end
