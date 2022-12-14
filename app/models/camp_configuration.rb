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
#  application_fee_required  :boolean
#
class CampConfiguration < ApplicationRecord
  has_many :camp_occurrences, dependent: :destroy

  validates :camp_year, presence: true, uniqueness: true
  validates :application_open, presence: true
  validates :application_close, presence: true
  validates :priority, presence: true
  validates :application_materials_due, presence: true
  validates :camper_acceptance_due, presence: true
  validate :only_one_active_camp

  monetize :application_fee_cents

  scope :active, -> { where(active: true) }

  scope :active_camp_year, -> { self.active.pick(:camp_year) }
  scope :active_camp_year_application_open, -> { self.active.pick(:application_open) }
  scope :active_camp_year_application_close, -> { self.active.pick(:application_close) }
  scope :active_camp_materials_due_date, -> { self.active.pick(:application_materials_due) }
  scope :active_camp_fee_cents, -> { self.active.pick(:application_fee_cents) }

  def display_name
    self.camp_year # or whatever column you want
  end

  def only_one_active_camp
    return unless active?
  
    matches = CampConfiguration.active
    if persisted?
      matches = matches.where('id != ?', id)
    end
    if matches.exists?
      errors.add(:active, 'cannot have another active camp')
    end
  end

  def dup
    super.tap do |new_camp_configuration|

      new_camp_configuration.camp_year = ""
      new_camp_configuration.application_open = ""
      new_camp_configuration.application_close = ""
      new_camp_configuration.application_materials_due = ""
      new_camp_configuration.priority = ""
      new_camp_configuration.camper_acceptance_due = ""
      new_camp_configuration.active = ""
      new_camp_configuration.student_packet_url = ""

    end
  end
end
