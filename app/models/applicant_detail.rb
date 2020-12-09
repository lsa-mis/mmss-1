# == Schema Information
#
# Table name: applicant_details
#
#  id                 :bigint           not null, primary key
#  user_id            :bigint           not null
#  firstname          :string           not null
#  middlename         :string
#  lastname           :string           not null
#  gender             :string
#  us_citizen         :boolean          default(FALSE), not null
#  demographic        :string
#  birthdate          :date             not null
#  diet_restrictions  :string
#  shirt_size         :string
#  address1           :string           not null
#  address2           :string
#  city               :string           not null
#  state              :string           not null
#  state_non_us       :string
#  postalcode         :string           not null
#  country            :string           not null
#  phone              :string           not null
#  parentname         :string           not null
#  parentaddress1     :string
#  parentaddress2     :string
#  parentcity         :string
#  parentstate        :string
#  parentstate_non_us :string
#  parentzip          :string
#  parentcountry      :string
#  parentphone        :string           not null
#  parentworkphone    :string
#  parentemail        :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class ApplicantDetail < ApplicationRecord
  belongs_to :user, required: true, inverse_of: :applicant_detail

  validates :firstname, presence: true
  validates :lastname, presence: true
  # validates :us_citizen, presence: true
  validates :gender, presence: true
  validates :birthdate, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :state, presence: { message: "needs to be selected or if you are
                                          outside of the US select *Non-US*" }
  validates :postalcode, presence: true
  validates :country, presence: true
  validates :phone, presence: true, format: { with: /\A(\+|00)?[1-9][0-9 \-?\(\)\.]{7,}\z/, message: "number format should be xxx-xxx-xxxx"}

  validates :parentname, presence: true
  validates :parentphone, presence: true, format: { with: /\A(\+|00)?[1-9][0-9 \-?\(\)\.]{7,}\z/, message: "number format should be xxx-xxx-xxxx"}
  validates :parentemail, presence: true, length: {maximum: 255},
                    format: {with: URI::MailTo::EMAIL_REGEXP, message: "only allows valid emails"}


def full_name
  "#{firstname} #{lastname}"
end

def applicant_email
  User.find(self.user_id).email 
end# or whatever column you wantend

def gender_name
  Gender.find(self.gender).name
end

def demographic_name
  if self.demographic.empty?
    "None Selected"
  else
    Demographic.find(self.demographic).name
  end
end


  # def applicant_profile_link
  #   if self.find(current_user)
  #     edit_applicant_detail_path(current_user)
  #   else
  #     new_applicant_detail_path(current_user)
  #   end
  # end
end
