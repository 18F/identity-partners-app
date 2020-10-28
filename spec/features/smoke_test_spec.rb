require 'rails_helper'

RSpec.describe 'Smoke test', type: :feature do
  it 'works' do
    visit root_path
    expect(page).to have_content('Welcome')
  end
end
