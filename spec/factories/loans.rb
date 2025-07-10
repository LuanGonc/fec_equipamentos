FactoryBot.define do
  factory :loan do
    association :equipment
    association :collaborator
    loan_action { "emprestimo" }
    loan_date { Date.today }

    trait :devolucao do
      loan_action { "devolucao" }
      return_date { Date.today }
      return_reason { "Devolução após uso" }
    end

    trait :baixa do
      loan_action { "baixa" }
      discard_date { Date.today }
      discard_reason { "Equipamento danificado" }
    end
  end
end
