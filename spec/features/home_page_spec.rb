require 'rails_helper'

RSpec.describe "Home Page", type: :feature do
  it 'shows \"Appointment Management\" System' do
    visit root_path
    expect(page).to have_content("Appointment Management System")
  end
end
