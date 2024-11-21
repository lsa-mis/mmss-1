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
    date_occurs { Faker::Date.between(from: 1.year.ago, to: 1.year.from_now) }
    active { false }

    trait :active do
      active { true }
    end

    # Create an activity for a specific date range
    trait :for_camp_dates do
      after(:build) do |activity|
        if activity.camp_occurrence
          activity.date_occurs = Faker::Date.between(
            from: activity.camp_occurrence.begin_date,
            to: activity.camp_occurrence.end_date
          )
        end
      end
    end
  end
end
