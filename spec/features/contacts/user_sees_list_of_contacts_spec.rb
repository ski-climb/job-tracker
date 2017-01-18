require 'rails_helper'

describe "Viewing a list of contacts" do
  scenario "shows a list of names as links" do
    contact_1, contact_2, contact_3 = create_list(:contact, 3)
    visit contacts_path

    expect(page).to have_content(:button_or_link, contact_1.name)
    expect(page).to have_content(:button_or_link, contact_2.name)
    expect(page).to have_content(:button_or_link, contact_3.name)
  end
end
