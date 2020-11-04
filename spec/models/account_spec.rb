require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'validations' do
    subject { build(:account) }

    it { is_expected.to validate_presence_of(:lg_account_id) }
    it { is_expected.to validate_uniqueness_of(:lg_account_id).case_insensitive }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    subject { build(:account) }

    it { is_expected.to have_many(:iaa_gtcs) }
    it { is_expected.to have_many(:iaa_orders).through(:iaa_gtcs) }
    it { is_expected.to have_many(:integrations) }
  end
end
