require 'rails_helper'

RSpec.describe Integration, type: :model do
  describe 'validations' do
    subject { build(:integration) }

    it { is_expected.to validate_presence_of(:issuer) }
    it { is_expected.to validate_uniqueness_of(:issuer).case_insensitive }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:protocol) }
    it { is_expected.to define_enum_for(:protocol).with_values(oidc: 'oidc', saml: 'saml').backed_by_column_of_type(:string) }
  end

  describe 'associations' do
    subject { build(:integration) }

    it { is_expected.to belong_to(:account).dependent(:destroy) }
  end
end
