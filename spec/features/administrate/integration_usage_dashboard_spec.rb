require 'rails_helper'

RSpec.describe 'Integration Usage dashboard', type: :feature do
  context 'as an admin' do
    let(:admin) { create(:user, admin: true) }

    before { sign_in_with_warden(admin) }

    describe 'index' do
      it 'works' do
        visit admin_integration_usages_path
        expect(page).to have_content('Back to app')
      end
    end

    describe 'create' do
      let!(:iaa_order) { create(:iaa_order) }
      let!(:integration) { create(:integration) }

      it 'works' do
        visit admin_integration_usages_path
        click_on 'New Integration Usage'
        select iaa_order.name, from: 'IAA order'
        select integration.name, from: 'Integration'
        click_on 'Create Integration usage'
        expect(page).to have_content('Integration Usage was successfully created.')
        # implictly tests the show view since that's where it redirects
      end
    end

    describe 'update' do
      let(:old_auths) { 0 }
      let(:new_auths) { 1000 }
      let(:integration_usage) { create(:integration_usage, auths: old_auths) }

      it 'works' do
        visit admin_integration_usage_path(integration_usage)
        click_on "Edit Integration Usage ##{integration_usage.id}"
        fill_in 'Auths', with: new_auths
        click_on 'Update Integration usage'
        expect(page).to have_content('Integration Usage was successfully updated.')
      end
    end

    describe 'destroy' do
      let!(:integration_usage) { create(:integration_usage) }

      it 'works' do
        visit admin_integration_usages_path
        within "tr[data-url=\"#{admin_integration_usage_path(integration_usage)}\"]" do
          click_on 'Destroy'
        end
        expect(page).to have_content('Integration Usage was successfully destroyed.')
      end
    end
  end
end
