require 'rails_helper'

describe "Viewing one contact" do
  scenario "shows the contact's details" do
    contact = create(:contact)
    visit contact_path(contact)

    expect(page).to have_content contact.name
    expect(page).to have_content contact.email
    expect(page).to have_content contact.position
    expect(page).to have_content contact.company_name
  end
end
