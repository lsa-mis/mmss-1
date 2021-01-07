# == Schema Information
#
# Table name: campnotes
#
#  id         :bigint           not null, primary key
#  note       :string
#  opendate   :datetime
#  closedate  :datetime
#  notetype   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Campnote < ApplicationRecord
  validates :note, :notetype, presence: true

  validates :opendate, :closedate, presence: true, availability: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if closedate.blank? || opendate.blank?

    if closedate < opendate
      errors.add(:closedate, "must be after the start date")
    end
 end

end
