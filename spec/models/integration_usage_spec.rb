require 'rails_helper'

RSpec.describe IntegrationUsage, type: :model do
  describe 'validations' do
    # subject { build(:integration_usage) }
    subject { described_class.new }

    it { is_expected.to validate_presence_of(:auths) }
    it { is_expected.to validate_numericality_of(:auths).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    subject { described_class.new }

    it { is_expected.to belong_to(:iaa_order) }
    it { is_expected.to belong_to(:integration) }
  end
end
