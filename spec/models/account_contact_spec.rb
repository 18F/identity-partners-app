require 'rails_helper'

RSpec.describe AccountContact, type: :model do
  describe 'validations' do
    subject { build(:account_contact) }

    it { is_expected.to validate_presence_of(:account) }
    it { is_expected.to validate_presence_of(:user) }

    describe 'user' do
      it 'must be unique scoped to account' do
        user = create(:user)
        account_contact = create(:account_contact, user: user)
        other_contact = build(
          :account_contact,
          account: account_contact.account,
          user: user
        )

        expect(other_contact).not_to be_valid
      end
    end
  end

  describe 'associations' do
    subject { build(:account_contact) }

    it { is_expected.to belong_to(:account) }
    it { is_expected.to belong_to(:user) }
  end
end
