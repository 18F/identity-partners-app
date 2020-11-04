require 'rails_helper'

RSpec.describe 'IAA Order dashboard', type: :feature do
  context 'as an admin' do
    let(:admin) { create(:user, admin: true) }

    before { sign_in_with_warden(admin) }

    describe 'index' do
      it 'works' do
        visit admin_iaa_orders_path
        expect(page).to have_content('Back to app')
      end
    end

    describe 'create' do
      let!(:gtc) { create(:iaa_gtc) }

      it 'works' do
        visit admin_iaa_orders_path
        click_on 'New IAA Order'
        select gtc.name, from: 'IAA GTC'
        fill_in 'Order number', with: 1
        click_on 'Create IAA order'
        expect(page).to have_content('IAA Order was successfully created.')
        # implictly tests the show view since that's where it redirects
      end
    end

    describe 'update' do
      let(:old_number) { 1 }
      let(:new_number) { 2 }
      let(:iaa_order) { create(:iaa_order, order_number: old_number) }

      it 'works' do
        visit admin_iaa_order_path(iaa_order)
        click_on "Edit #{iaa_order.name}"
        fill_in 'Order number', with: new_number
        click_on 'Update IAA order'
        expect(page).to have_content('IAA Order was successfully updated.')
      end
    end

    describe 'destroy' do
      let!(:iaa_order) { create(:iaa_order) }

      it 'works' do
        visit admin_iaa_orders_path
        within "tr[data-url=\"#{admin_iaa_order_path(iaa_order)}\"]" do
          click_on 'Destroy'
        end
        expect(page).to have_content('IAA Order was successfully destroyed.')
      end
    end
  end
end

