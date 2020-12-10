# == Schema Information
#
# Table name: recuploads
#
#  id                :bigint           not null, primary key
#  letter            :text
#  authorname        :string           not null
#  studentname       :string           not null
#  recommendation_id :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Recupload < ApplicationRecord
  belongs_to :recommendation

  # validates :letter, length: { minimum: 50 }
  validates :authorname, presence: true
  validates :studentname, presence: true

  has_one_attached :recletter

  validate :acceptable_recletter

  private

  def acceptable_recletter
    return unless recletter.attached?

    unless recletter.blob.byte_size <= 5.megabyte
      errors.add(:recletter, "is too big - file size cannot exceed 5Mbyte")
    end

    acceptable_types = ["image/png", "image/jpeg", "application/pdf"]
    unless acceptable_types.include?(recletter.content_type)
      errors.add(:recletter, "must be file type PDF, JPEG or PNG")
    end
  end

end
