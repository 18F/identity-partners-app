require 'rails_helper'

RSpec.describe 'Account Contact dashboard', type: :feature do
  context 'as an admin' do
    let(:admin) { create(:user, admin: true) }

    before { sign_in_with_warden(admin) }

    describe 'index' do
      it 'works' do
        visit admin_account_contacts_path
        expect(page).to have_content('Back to app')
      end
    end

    describe 'create' do
      let!(:account) { create(:account) }
      let!(:user) { create(:user) }

      it 'works' do
        visit admin_account_contacts_path
        click_on 'New Account Contact'
        select account.name, from: 'Account'
        select user.email, from: 'User'
        click_on 'Create Account contact'
        expect(page).to have_content('Account Contact was successfully created.')
        # implictly tests the show view since that's where it redirects
      end
    end

    describe 'destroy' do
      let!(:account_contact) { create(:account_contact) }

      it 'works' do
        visit admin_account_contacts_path
        within "tr[data-url=\"#{admin_account_contact_path(account_contact)}\"]" do
          click_on 'Destroy'
        end
        expect(page).to have_content('Account Contact was successfully destroyed.')
      end
    end
  end
end
