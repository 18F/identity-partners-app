require 'rails_helper'

RSpec.describe 'Account dashboard', type: :feature do
  context 'as an admin' do
    let(:admin) { create(:user, admin: true) }

    before { sign_in_with_warden(admin) }

    describe 'index' do
      it 'works' do
        visit admin_accounts_path
        expect(page).to have_content('Back to app')
      end
    end

    describe 'create' do
      let!(:agency) { create(:agency) }

      it 'works' do
        visit admin_accounts_path
        click_on 'New Account'
        select agency.name, from: 'Agency'
        fill_in 'LG identifier', with: 'LG-E-FOO'
        fill_in 'Name', with: 'Federal Office of Operations'
        click_on 'Create Account'
        expect(page).to have_content('Account was successfully created.')
        # implictly tests the show view since that's where it redirects
      end
    end

    describe 'update' do
      let(:old_name) { 'Bureau of Amazing Resources' }
      let(:new_name) { 'Bureau of Awesome Resources' }
      let(:account) { create(:account, name: old_name) }

      it 'works' do
        visit admin_account_path(account)
        click_on "Edit #{account.name}"
        fill_in 'Name', with: new_name
        click_on 'Update Account'
        expect(page).to have_content('Account was successfully updated.')
      end
    end

    describe 'destroy' do
      let!(:account) { create(:account) }

      it 'works' do
        visit admin_accounts_path
        within "tr[data-url=\"#{admin_account_path(account)}\"]" do
          click_on 'Destroy'
        end
        expect(page).to have_content('Account was successfully destroyed.')
      end
    end
  end

  context 'as non-admin' do
    let(:user) { create(:user, admin: false) }

    before { sign_in_with_warden(user) }

    describe 'dashboard' do
      it 'is not permitted' do
        visit admin_accounts_path
        expect(page).to have_content('You are not permitted to view that page.')
      end
    end
  end
end
