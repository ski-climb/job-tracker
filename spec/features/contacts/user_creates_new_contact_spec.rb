require 'rails_helper'

describe "User creates a new contact" do
  scenario "a user sees helpful errors and nothing is saved to the database when invalid information is entered" do
    visit root_path
    click_on "Contacts" 
    click_on "Add a new contact"

    fill_in "contact[name]", with: ""
    click_button "Create"

    expect(page).to have_content "Name can't be blank"
    expect(Contact.count).to eq 0
  end

  scenario "a user can create a new contact" do
    company = create(:company)
    visit root_path
    click_on "Contacts" 
    click_on "Add a new contact"

    fill_in "contact[name]", with: "Thister Thistleton"
    fill_in "contact[position]", with: "Pastry Chef"
    fill_in "contact[email]", with: "example@test.com"
    select company.name, from: "Company"

    click_button "Create"

    contact = Contact.find_by(name: "Thister Thistleton")
    expect(page).to have_current_path contacts_path
    expect(page).to have_content "#{contact.name} was successfully added as a contact"
    expect(page).to have_content contact.name
    expect(page).to have_content(:button_or_link, contact.name)
  end
end
