require 'rails_helper'

RSpec.describe IAAGTC, type: :model do
  describe 'validations' do
    subject { build(:iaa_gtc) }

    it { is_expected.to validate_presence_of(:gtc_number) }
    it { is_expected.to validate_uniqueness_of(:gtc_number).case_insensitive }
    it { is_expected.to validate_presence_of(:mod_number) }
    it { is_expected.to validate_numericality_of(:mod_number).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:estimated_amount).is_greater_than_or_equal_to(0).allow_nil }
  end

  describe 'associations' do
    subject { build(:iaa_gtc) }

    it { is_expected.to belong_to(:account).dependent(:destroy) }
    it { is_expected.to have_many(:iaa_orders) }
  end

  describe '#name' do
    it 'generates the appropriate IAA string' do
      iaa_gtc = build(:iaa_gtc, gtc_number: 'FOOBAR', mod_number: 2)

      expect(iaa_gtc.name).to eq('FOOBAR-0000-0002')
    end
  end
end
