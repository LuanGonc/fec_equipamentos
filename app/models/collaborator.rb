class Collaborator < ApplicationRecord
    has_many :loans, dependent: :destroy
    validates :name, :email, :department, presence: true
end
