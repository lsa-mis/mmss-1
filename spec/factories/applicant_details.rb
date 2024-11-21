# == Schema Information
#
# Table name: applicant_details
#
#  id                 :bigint           not null, primary key
#  user_id            :bigint           not null
#  firstname          :string(255)      not null
#  middlename         :string(255)
#  lastname           :string(255)      not null
#  gender             :string(255)
#  us_citizen         :boolean          default(FALSE), not null
#  birthdate          :date             not null
#  diet_restrictions  :text(65535)
#  shirt_size         :string(255)
#  address1           :string(255)      not null
#  address2           :string(255)
#  city               :string(255)      not null
#  state              :string(255)      not null
#  state_non_us       :string(255)
#  postalcode         :string(255)      not null
#  country            :string(255)      not null
#  phone              :string(255)      not null
#  parentname         :string(255)      not null
#  parentaddress1     :string(255)
#  parentaddress2     :string(255)
#  parentcity         :string(255)
#  parentstate        :string(255)
#  parentstate_non_us :string(255)
#  parentzip          :string(255)
#  parentcountry      :string(255)
#  parentphone        :string(255)      not null
#  parentworkphone    :string(255)
#  parentemail        :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  demographic_id     :bigint
#  demographic_other  :string(255)
#
FactoryBot.define do
  factory :applicant_detail do
    user
    firstname { "John" }
    lastname { "Doe" }
    birthdate { Date.today - 16.years }
    us_citizen { false }
    address1 { "123 Main St" }
    city { "Ann Arbor" }
    state { "MI" }
    postalcode { "48109" }
    country { "USA" }
    phone { "123-456-7890" }
    parentname { "Jane Doe" }
    parentphone { "123-456-7890" }
    gender { 'Female' }
    shirt_size { 'M' }
    demographic_id { create(:demographic).id }
    parentemail { 'parent@example.com' }
  end
end
