# == Schema Information
#
# Table name: feedbacks
#
#  id         :bigint           not null, primary key
#  genre      :string(255)
#  message    :string(255)
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :feedback do
    association :user
    genre { %w[bug suggestion other].sample }
    message { Faker::Lorem.sentence }
  end
end
