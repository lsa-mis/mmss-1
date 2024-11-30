# == Schema Information
#
# Table name: recuploads
#
#  id                :bigint           not null, primary key
#  letter            :text(65535)
#  authorname        :string(255)      not null
#  studentname       :string(255)      not null
#  recommendation_id :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
FactoryBot.define do
  factory :recupload do
    association :recommendation
    letter { Faker::Lorem.paragraph }
    authorname { Faker::Name.name }
    studentname { Faker::Name.name }
  end
end
