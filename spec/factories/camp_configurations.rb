# == Schema Information
#
# Table name: camp_configurations
#
#  id                        :bigint           not null, primary key
#  camp_year                 :integer          not null
#  application_open          :date             not null
#  application_close         :date             not null
#  priority                  :date             not null
#  application_materials_due :date             not null
#  camper_acceptance_due     :date             not null
#  active                    :boolean          default(FALSE), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  offer_letter              :text(65535)
#  student_packet_url        :string(255)
#  application_fee_cents     :integer
#  reject_letter             :text(65535)
#  waitlist_letter           :text(65535)
#
FactoryBot.define do
  factory :camp_configuration do
    sequence(:camp_year) { |n| Date.current.year + n }
    application_open { Date.current - 2.months }
    application_close { Date.current + 1.month }
    priority { Date.current - 1.month }
    application_materials_due { Date.current }
    camper_acceptance_due { Date.current + 2.weeks }
    active { false }
    offer_letter { "Congratulations on your acceptance!" }
    reject_letter { "We regret to inform you..." }
    waitlist_letter { "You are on the waitlist." }
  end
end
