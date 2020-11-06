require 'rails_helper'

RSpec.describe 'Integration Contact dashboard', type: :feature do
  context 'as an admin' do
    let(:admin) { create(:user, admin: true) }

    before { sign_in_with_warden(admin) }

    describe 'index' do
      it 'works' do
        visit admin_integration_contacts_path
        expect(page).to have_content('Back to app')
      end
    end

    describe 'create' do
      let!(:integration) { create(:integration) }
      let!(:user) { create(:user) }

      it 'works' do
        visit admin_integration_contacts_path
        click_on 'New Integration Contact'
        select integration.name, from: 'Integration'
        select user.email, from: 'User'
        click_on 'Create Integration contact'
        expect(page).to have_content('Integration Contact was successfully created.')
        # implictly tests the show view since that's where it redirects
      end
    end

    describe 'destroy' do
      let!(:integration_contact) { create(:integration_contact) }

      it 'works' do
        visit admin_integration_contacts_path
        within "tr[data-url=\"#{admin_integration_contact_path(integration_contact)}\"]" do
          click_on 'Destroy'
        end
        expect(page).to have_content('Integration Contact was successfully destroyed.')
      end
    end
  end
end
