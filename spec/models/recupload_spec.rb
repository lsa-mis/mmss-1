# == Schema Information
#
# Table name: recuploads
#
#  id                :bigint           not null, primary key
#  letter            :text(65535)
#  authorname        :string(255)      not null
#  studentname       :string(255)      not null
#  recommendation_id :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'rails_helper'

RSpec.describe Recupload, type: :model do
  describe 'validations' do
    subject { build(:recupload) }

    it { should belong_to(:recommendation) }
    it { should validate_presence_of(:authorname) }
    it { should validate_presence_of(:studentname) }
  end

  describe 'file attachment' do
    let(:recupload) { build(:recupload) }

    context 'with valid file' do
      before do
        recupload.recletter.attach(
          io: File.open(Rails.root.join('spec', 'files', 'test.pdf')),
          filename: 'test.pdf',
          content_type: 'application/pdf'
        )
      end

      it 'is valid with a PDF' do
        expect(recupload).to be_valid
      end
    end

    context 'with invalid file size' do
      before do
        allow(recupload.recletter.blob).to receive(:byte_size).and_return(21.megabytes)
      end

      it 'is invalid' do
        expect(recupload).not_to be_valid
      end
    end
  end
end
