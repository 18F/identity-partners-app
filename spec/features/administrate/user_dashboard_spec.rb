require 'rails_helper'

RSpec.describe 'User dashboard', type: :feature do
  context 'as an admin' do
    let(:admin) { create(:user, admin: true) }

    before { sign_in_with_warden(admin) }

    describe 'index' do
      it 'works' do
        visit admin_users_path
        expect(page).to have_content('Back to app')
      end
    end

    describe 'create' do
      it 'works' do
        visit admin_users_path
        click_on 'New user'
        fill_in 'Email', with: 'foo@example.com'
        click_on 'Create User'
        expect(page).to have_content('User was successfully created.')
        # implictly tests the show view since that's where it redirects
      end
    end

    describe 'update' do
      let(:old_email) { 'foo@example.com' }
      let(:new_email) { 'bar@example.com' }
      let(:user) { create(:user, email: old_email) }

      it 'works' do
        visit admin_user_path(user)
        click_on "Edit User ##{user.id}"
        fill_in 'Email', with: new_email
        click_on 'Update User'
        expect(page).to have_content('User was successfully updated.')
      end
    end

    describe 'destroy' do
      let!(:user) { create(:user) }

      it 'works' do
        visit admin_users_path
        within "tr[data-url=\"#{admin_user_path(user)}\"]" do
          click_on 'Destroy'
        end
        expect(page).to have_content('User was successfully destroyed.')
      end
    end
  end
end
