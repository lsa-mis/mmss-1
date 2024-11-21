# == Schema Information
#
# Table name: admins
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
FactoryBot.define do
  factory :admin do
    email { Faker::Internet.unique.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    sign_in_count { 0 }
    current_sign_in_at { nil }
    last_sign_in_at { nil }
    current_sign_in_ip { nil }
    last_sign_in_ip { nil }
    failed_attempts { 0 }
    unlock_token { nil }
    locked_at { nil }
    reset_password_token { nil }
    reset_password_sent_at { nil }
    remember_created_at { nil }

    trait :locked do
      failed_attempts { 3 }
      locked_at { Time.current }
      unlock_token { Devise.friendly_token }
    end

    trait :with_sign_in_history do
      sign_in_count { 1 }
      current_sign_in_at { Time.current }
      last_sign_in_at { 1.day.ago }
      current_sign_in_ip { '127.0.0.1' }
      last_sign_in_ip { '127.0.0.1' }
    end
  end
end
