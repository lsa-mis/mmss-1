# == Schema Information
#
# Table name: enrollments
#
#  id                          :bigint           not null, primary key
#  user_id                     :bigint           not null
#  international               :boolean          default(FALSE), not null
#  high_school_name            :string           not null
#  high_school_address1        :string           not null
#  high_school_address2        :string
#  high_school_city            :string           not null
#  high_school_state           :string
#  high_school_non_us          :string
#  high_school_postalcode      :string
#  high_school_country         :string           not null
#  year_in_school              :string           not null
#  anticipated_graduation_year :string           not null
#  room_mate_request           :string
#  personal_statement          :text             not null
#  notes                       :text
#  application_status          :string
#  offer_status                :string
#  partner_program             :string
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  campyear                    :integer
#  application_deadline        :date
#
class Enrollment < ApplicationRecord
  after_update :send_offer_letter
  before_update :set_application_deadline

  belongs_to :user
  has_one :applicant_detail, through: :user

  has_many :enrollment_activities, dependent: :destroy
  has_many :registration_activities, through: :enrollment_activities, source: :activity

  has_many :session_activities, dependent: :destroy 
  has_many :session_registrations, through: :session_activities, source: :camp_occurrence

  has_many :session_assignments, dependent: :destroy
  accepts_nested_attributes_for :session_assignments, allow_destroy: true

  has_many :course_preferences, dependent: :destroy
  has_many :course_registrations, through: :course_preferences, source: :course
  accepts_nested_attributes_for :course_preferences, allow_destroy: true

  has_many :course_assignments, dependent: :destroy
  accepts_nested_attributes_for :course_assignments, allow_destroy: true

  has_many :financial_aids, dependent: :destroy
  has_many :travels, dependent: :destroy
  has_one :recommendation, dependent: :destroy

  has_one_attached :transcript
  has_one_attached :student_packet

  validates :high_school_name, presence: true
  validates :high_school_address1, presence: true
  validates :high_school_city, presence: true
  validates :high_school_country, presence: true
  validates :year_in_school, presence: true
  validates :anticipated_graduation_year, presence: true
  validates :personal_statement, presence: true
  validates :personal_statement, length: { minimum: 100 }

  validate :at_least_one_session_is_checked
  validate :at_least_one_course_is_checked

  validate :validate_transcript_presence
  validate :acceptable_transcript

  validate :acceptable_student_packet

  scope :current_camp_year_applications, -> { where('campyear = ? ', CampConfiguration.active_camp_year) }
  scope :offered, -> { current_camp_year_applications.where("offer_status = 'offered'")}
  scope :accepted, -> { current_camp_year_applications.where("offer_status = 'accepted'")}
  scope :enrolled, -> { current_camp_year_applications.where("application_status = 'enrolled'")}
  scope :application_complete, -> {  current_camp_year_applications.where("application_status = 'application complete'")}

  def display_name
    "#{self.applicant_detail.full_name} - #{self.user.email}"
  end

  private

  def at_least_one_session_is_checked
    if session_registration_ids.empty?
      errors.add(:base, "Select at least one session")
    end
  end

  def at_least_one_course_is_checked
    if course_registration_ids.empty?
      errors.add(:base, "Select at least one course")
    end
  end

  def validate_transcript_presence
    errors.add(:transcript, 'should exist') unless self.transcript.attached?
  end

  def acceptable_transcript
    return unless transcript.attached?

    unless transcript.blob.byte_size <= 20.megabyte
      errors.add(:transcript, "is too big - file size cannot exceed 20Mbyte")
    end

    acceptable_types = ["image/png", "image/jpeg", "application/pdf"]
    unless acceptable_types.include?(transcript.content_type)
      errors.add(:transcript, "must be file type PDF, JPEG or PNG")
    end
  end

  def acceptable_student_packet
    return unless student_packet.attached?

    unless student_packet.blob.byte_size <= 20.megabyte
      errors.add(:student_packet, "is too big - file size cannot exceed 20Mbyte")
    end

    acceptable_types = ["image/png", "image/jpeg", "application/pdf"]
    unless acceptable_types.include?(student_packet.content_type)
      errors.add(:student_packet, "must be file type PDF, JPEG or PNG")
    end
  end

  def send_offer_letter
    if self.offer_status == "offered"
      OfferMailer.offer_email(self.user_id).deliver_now
    end
  end

  def set_application_deadline
    if self.session_assignments.present? && self.course_assignments.present?
      self.application_deadline = 30.days.from_now unless self.application_deadline.present?
    end
  end

end
