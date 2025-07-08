class Collaborator < ApplicationRecord
    validates :name, :email, :department, presence: true
end
