FactoryBot.define do
  factory :equipment do
    sequence(:patrimony_number) { |n| "PAT#{n}" } # Gera PAT1, PAT2, etc automaticamente
    sequence(:serial_number) { |n| "SN#{n}" }
    sequence(:identifier) { |n| "EQ#{n}" }
    brand { 'Dell' }
    model { 'XPS' }
    purchase_date { Date.today }
    status { 'disponivel' } # Note o acento (deve bater com seu enum)
  end
end
