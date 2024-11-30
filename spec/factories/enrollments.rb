# == Schema Information
#
# Table name: enrollments
#
#  id                            :bigint           not null, primary key
#  user_id                       :bigint           not null
#  international                 :boolean          default(FALSE), not null
#  high_school_name              :string(255)      not null
#  high_school_address1          :string(255)      not null
#  high_school_address2          :string(255)
#  high_school_city              :string(255)      not null
#  high_school_state             :string(255)
#  high_school_non_us            :string(255)
#  high_school_postalcode        :string(255)
#  high_school_country           :string(255)      not null
#  year_in_school                :string(255)      not null
#  anticipated_graduation_year   :string(255)      not null
#  room_mate_request             :string(255)
#  personal_statement            :text(65535)      not null
#  notes                         :text(65535)
#  application_status            :string(255)
#  offer_status                  :string(255)
#  partner_program               :string(255)
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  campyear                      :integer
#  application_deadline          :date
#  application_status_updated_on :date
#  uniqname                      :string(255)
#  camp_doc_form_completed       :boolean          default(FALSE)
#
FactoryBot.define do
  factory :enrollment do
    association :user
    
    # Required fields
    high_school_name { Faker::University.name }
    high_school_address1 { Faker::Address.street_address }
    high_school_city { Faker::Address.city }
    high_school_country { "US" }
    year_in_school { "Junior" }
    anticipated_graduation_year { (Date.current.year + 2).to_s }
    personal_statement { Faker::Lorem.paragraph(sentence_count: 3) }
    campyear { Date.current.year }

    # Transient attributes to help with associations
    transient do
      session_registration_ids { CampOccurrence.pluck(:id) }
      course_registration_ids { Course.pluck(:id) }
    end

    after(:build) do |enrollment, evaluator|
      # Ensure session and course registrations
      enrollment.session_registration_ids = evaluator.session_registration_ids
      enrollment.course_registration_ids = evaluator.course_registration_ids
    end
  end
end
