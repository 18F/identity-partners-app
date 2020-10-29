require 'rails_helper'

RSpec.describe 'IAA dashboard', type: :feature do
  context 'as an admin' do
    let(:admin) { create(:user, admin: true) }

    before { sign_in_with_warden(admin) }

    describe 'index' do
      it 'works' do
        visit admin_iaas_path
        expect(page).to have_content('Back to app')
      end
    end

    describe 'create' do
      let!(:account) { create(:account) }

      it 'works' do
        visit admin_iaas_path
        click_on 'New IAA'
        select account.name, from: 'Account'
        fill_in 'Number', with: 'LGFOOFY210001'
        click_on 'Create IAA'
        expect(page).to have_content('IAA was successfully created.')
        # implictly tests the show view since that's where it redirects
      end
    end

    describe 'update' do
      let(:old_number) { 'LGFOOFY210001' }
      let(:new_number) { 'LGBARFY210001' }
      let(:iaa) { create(:iaa, number: old_number) }

      it 'works' do
        visit admin_iaa_path(iaa)
        click_on "Edit #{iaa.number}"
        fill_in 'Number', with: new_number
        click_on 'Update IAA'
        expect(page).to have_content('IAA was successfully updated.')
      end
    end

    describe 'destroy' do
      let!(:iaa) { create(:iaa) }

      it 'works' do
        visit admin_iaas_path
        within "tr[data-url=\"#{admin_iaa_path(iaa)}\"]" do
          click_on 'Destroy'
        end
        expect(page).to have_content('IAA was successfully destroyed.')
      end
    end
  end
end

