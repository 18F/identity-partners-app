require 'rails_helper'

RSpec.describe 'Integration Status dashboard', type: :feature do
  context 'as an admin' do
    let(:admin) { create(:user, admin: true) }

    before { sign_in_with_warden(admin) }

    describe 'index' do
      it 'works' do
        visit admin_integration_statuses_path
        expect(page).to have_content('Back to app')
      end
    end

    describe 'create' do
      it 'works' do
        visit admin_integration_statuses_path
        click_on 'New Integration Status'
        fill_in 'Name', with: 'pending'
        fill_in 'Order', with: 0
        click_on 'Create Integration status'
        expect(page).to have_content('Integration Status was successfully created.')
        # implictly tests the show view since that's where it redirects
      end
    end

    describe 'update' do
      let(:old_name) { 'pending' }
      let(:new_name) { 'soon to be' }
      let(:integration_status) { create(:integration_status, name: old_name) }

      it 'works' do
        visit admin_integration_status_path(integration_status)
        click_on "Edit #{integration_status.name}"
        fill_in 'Name', with: new_name
        click_on 'Update Integration status'
        expect(page).to have_content('Integration Status was successfully updated.')
      end
    end

    describe 'destroy' do
      let!(:integration_status) { create(:integration_status) }

      it 'works' do
        visit admin_integration_statuses_path
        within "tr[data-url=\"#{admin_integration_status_path(integration_status)}\"]" do
          click_on 'Destroy'
        end
        expect(page).to have_content('Integration Status was successfully destroyed.')
      end
    end
  end
end
