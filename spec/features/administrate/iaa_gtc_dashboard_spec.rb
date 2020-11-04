require 'rails_helper'

RSpec.describe 'IAA GTC dashboard', type: :feature do
  context 'as an admin' do
    let(:admin) { create(:user, admin: true) }

    before { sign_in_with_warden(admin) }

    describe 'index' do
      it 'works' do
        visit admin_iaa_gtcs_path
        expect(page).to have_content('Back to app')
      end
    end

    describe 'create' do
      let!(:account) { create(:account) }

      it 'works' do
        visit admin_iaa_gtcs_path
        click_on 'New IAA GTC'
        select account.name, from: 'Account'
        fill_in 'GTC number', with: 'LGFOOFY210001'
        click_on 'Create IAA GTC'
        expect(page).to have_content('IAA GTC was successfully created.')
        # implictly tests the show view since that's where it redirects
      end
    end

    describe 'update' do
      let(:old_number) { 'LGFOOFY210001' }
      let(:new_number) { 'LGBARFY210001' }
      let(:iaa_gtc) { create(:iaa_gtc, gtc_number: old_number) }

      it 'works' do
        visit admin_iaa_gtc_path(iaa_gtc)
        click_on "Edit #{iaa_gtc.gtc_number}"
        fill_in 'GTC number', with: new_number
        click_on 'Update IAA GTC'
        expect(page).to have_content('IAA GTC was successfully updated.')
      end
    end

    describe 'destroy' do
      let!(:iaa_gtc) { create(:iaa_gtc) }

      it 'works' do
        visit admin_iaa_gtcs_path
        within "tr[data-url=\"#{admin_iaa_gtc_path(iaa_gtc)}\"]" do
          click_on 'Destroy'
        end
        expect(page).to have_content('IAA GTC was successfully destroyed.')
      end
    end
  end
end

