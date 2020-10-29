require 'rails_helper'

RSpec.describe IAA, type: :model do
  describe 'validations' do
    subject { build(:iaa) }

    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_uniqueness_of(:number).case_insensitive }
    it { is_expected.to validate_numericality_of(:estimated_amount).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:billed_amount).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    subject { build(:iaa) }

    it { is_expected.to belong_to(:account).dependent(:destroy) }
  end
end
