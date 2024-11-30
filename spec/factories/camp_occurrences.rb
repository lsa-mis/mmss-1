FactoryBot.define do
  factory :camp_occurrence do
    association :camp_configuration
    
    sequence(:description) { |n| "Summer Session #{n}" }
    
    begin_date { camp_configuration.application_open + 1.month }
    end_date { camp_configuration.application_close + 1.month }
    
    cost_cents { 10_000 }
    active { false }
  end
end 