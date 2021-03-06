require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'validations' do
    subject { build(:account) }

    it { is_expected.to validate_presence_of(:lg_identifier) }
    it { is_expected.to validate_uniqueness_of(:lg_identifier).case_insensitive }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    subject { build(:account) }

    it { is_expected.to belong_to(:account_status).optional }
    it { is_expected.to belong_to(:agency) }
    it { is_expected.to have_many(:account_contacts).dependent(:destroy) }
    it { is_expected.to have_many(:contacts).through(:account_contacts).source(:user) }
    it { is_expected.to have_many(:iaa_gtcs).dependent(:destroy) }
    it { is_expected.to have_many(:iaa_orders).through(:iaa_gtcs) }
    it { is_expected.to have_many(:integrations).dependent(:destroy) }
  end
end
