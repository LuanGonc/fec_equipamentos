class Collaborator < ApplicationRecord
    has_many :loans, dependent: :destroy
    validates :name, :email, :department, presence: true

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "department", "email", "id", "id_value", "name", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["loans"]
    end



    validates :name, :email, :department, presence: true
    validate :valid_email_format  # Usando nossa validação personalizada

    private

    def valid_email_format
        # Verifica se está em branco
        return if email.blank?  

        
        unless URI::MailTo::EMAIL_REGEXP.match?(email) #regex do ruby para formato do email
            errors.add(:email, "não é um formato válido")
            return
        end
    end

end
