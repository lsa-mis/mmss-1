# == Schema Information
#
# Table name: payments
#
#  id                 :bigint           not null, primary key
#  transaction_type   :string(255)
#  transaction_status :string(255)
#  transaction_id     :string(255)
#  total_amount       :string(255)
#  transaction_date   :string(255)
#  account_type       :string(255)
#  result_code        :string(255)
#  result_message     :string(255)
#  user_account       :string(255)
#  payer_identity     :string(255)
#  timestamp          :string(255)
#  transaction_hash   :string(255)
#  user_id            :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  camp_year          :integer
#
FactoryBot.define do
  factory :payment do
    association :user
    transaction_type { "Purchase" }
    transaction_status { "Completed" }
    transaction_id { SecureRandom.hex(10) }
    total_amount { "100.00" }
    transaction_date { Date.current }
    account_type { "Credit" }
    result_code { "SUCCESS" }
    result_message { "Payment processed successfully" }
    user_account { "test_account" }
    payer_identity { Faker::Internet.username }
    timestamp { Time.current }
    transaction_hash { SecureRandom.hex(16) }
    camp_year { Date.current.year }
  end
end
