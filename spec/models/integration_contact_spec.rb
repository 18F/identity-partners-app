require 'rails_helper'

RSpec.describe IntegrationContact, type: :model do
  describe 'validations' do
    subject { build(:integration_contact) }

    it { is_expected.to validate_presence_of(:integration) }
    it { is_expected.to validate_presence_of(:user) }

    describe 'user' do
      it 'must be unique scoped to integration' do
        user = create(:user)
        integration_contact = create(:integration_contact, user: user)
        other_contact = build(
          :integration_contact,
          integration: integration_contact.integration,
          user: user
        )

        expect(other_contact).not_to be_valid
      end
    end
  end

  describe 'associations' do
    subject { build(:integration_contact) }

    it { is_expected.to belong_to(:integration) }
    it { is_expected.to belong_to(:user) }
  end
end
