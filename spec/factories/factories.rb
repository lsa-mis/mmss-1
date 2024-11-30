FactoryBot.define do
  sequence :email do |n|
    "user#{n}#{SecureRandom.hex(3)}@example.com"
  end

  sequence :username do |n|
    "user_#{n}_#{SecureRandom.hex(2)}"
  end

  trait :with_applicant_detail do
    after(:create) do |user|
      create(:applicant_detail, user: user)
    end
  end
end
