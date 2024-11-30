# == Schema Information
#
# Table name: faculties
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
FactoryBot.define do
  factory :faculty do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 10) }

    # Add a course to pass validation
    after(:build) do |faculty|
      create(:course, faculty_uniqname: faculty.email.split('@').first)
    end

    # Optional: If you want to create an associated camp configuration
    after(:build) do |faculty|
      create(:camp_configuration)
    end
  end
end
