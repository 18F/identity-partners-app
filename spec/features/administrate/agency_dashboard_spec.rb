require 'rails_helper'

RSpec.describe 'Agency dashboard', type: :feature do
  context 'as an admin' do
    let(:admin) { create(:user, admin: true) }

    before { sign_in_with_warden(admin) }

    describe 'index' do
      it 'works' do
        visit admin_agencies_path
        expect(page).to have_content('Back to app')
      end
    end

    describe 'create' do
      it 'works' do
        visit admin_agencies_path
        click_on 'New Agency'
        fill_in 'Name', with: 'General Widgets Administration'
        fill_in 'Abbreviation', with: 'GWA'
        fill_in 'LG identifier', with: 1
        click_on 'Create Agency'
        expect(page).to have_content('Agency was successfully created.')
        # implictly tests the show view since that's where it redirects
      end
    end

    describe 'update' do
      let(:old_name) { 'Bureau of Amazing Resources' }
      let(:new_name) { 'Bureau of Awesome Resources' }
      let(:agency) { create(:agency, name: old_name) }

      it 'works' do
        visit admin_agency_path(agency)
        click_on "Edit #{agency.name}"
        fill_in 'Name', with: new_name
        click_on 'Update Agency'
        expect(page).to have_content('Agency was successfully updated.')
      end
    end

    describe 'destroy' do
      let!(:agency) { create(:agency) }

      it 'works' do
        visit admin_agencies_path
        within "tr[data-url=\"#{admin_agency_path(agency)}\"]" do
          click_on 'Destroy'
        end
        expect(page).to have_content('Agency was successfully destroyed.')
      end
    end
  end
end
