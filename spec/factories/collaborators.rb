FactoryBot.define do
  factory :collaborator do
    name { "Fulano de Tal" }
    sequence(:email) { |n| "fulano#{n}@empresa.com" }
    department { "Financeiro" }
  end
end