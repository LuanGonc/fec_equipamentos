class Collaborator < ApplicationRecord
    has_many :loans, dependent: :destroy
    validates :name, :email, :department, presence: true

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "department", "email", "id", "id_value", "name", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["loans"]
    end

end
