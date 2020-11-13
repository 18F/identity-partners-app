require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:uuid).case_insensitive.allow_nil }
  end

  describe 'associations' do
    subject { build(:user) }

    it { is_expected.to have_many(:account_contacts) }
    it { is_expected.to have_many(:accounts).through(:account_contacts) }
    it { is_expected.to have_many(:integration_contacts) }
    it { is_expected.to have_many(:integrations).through(:integration_contacts) }
  end
end
