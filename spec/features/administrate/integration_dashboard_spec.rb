require 'rails_helper'

RSpec.describe 'Integration dashboard', type: :feature do
  context 'as an admin' do
    let(:admin) { create(:user, admin: true) }

    before { sign_in_with_warden(admin) }

    describe 'index' do
      it 'works' do
        visit admin_integrations_path
        expect(page).to have_content('Back to app')
      end
    end

    describe 'create' do
      let!(:account) { create(:account) }

      it 'works' do
        visit admin_integrations_path
        click_on 'New Integration'
        select account.name, from: 'Account'
        fill_in 'Issuer', with: 'urn:gov:gsa:openidconnect.profiles:sp:sso:gsa:foo'
        fill_in 'Name', with: 'Awesome App'
        click_on 'Create Integration'
        expect(page).to have_content('Integration was successfully created.')
        # implictly tests the show view since that's where it redirects
      end
    end

    describe 'update' do
      let(:old_name) { 'Awesome App' }
      let(:new_name) { 'Amazing App' }
      let(:integration) { create(:integration, name: old_name) }

      it 'works' do
        visit admin_integration_path(integration)
        click_on "Edit #{integration.name}"
        fill_in 'Name', with: new_name
        click_on 'Update Integration'
        expect(page).to have_content('Integration was successfully updated.')
      end
    end

    describe 'destroy' do
      let!(:integration) { create(:integration) }

      it 'works' do
        visit admin_integrations_path
        within "tr[data-url=\"#{admin_integration_path(integration)}\"]" do
          click_on 'Destroy'
        end
        expect(page).to have_content('Integration was successfully destroyed.')
      end
    end
  end
end
