# == Schema Information
#
# Table name: activities
#
#  id                 :bigint           not null, primary key
#  camp_occurrence_id :bigint
#  description        :string(255)
#  cost_cents         :integer
#  date_occurs        :date
#  active             :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
FactoryBot.define do
  factory :activity do
    association :camp_occurrence
    description { Faker::Lorem.sentence }
    cost_cents { Faker::Number.between(from: 1000, to: 100000) }
    date_occurs { camp_occurrence.begin_date + rand(14).days }
    active { false }
  end
end
