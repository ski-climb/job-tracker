require 'rails_helper'

describe "User creates a new contact" do
  scenario "a user sees helpful errors and nothing is saved to the database when invalid information is entered" do
    company = create(:company)
    visit company_path(company)
    fill_in "contact[name]", with: ""
    click_button "Create"

    expect(page).to have_content "Contact must have a Name and Email to be valid."
    expect(Contact.count).to eq 0
  end

  scenario "a user can create a new contact" do
    company = create(:company)
    visit company_path(company)

    fill_in "contact[name]", with: "Thister Thistleton"
    fill_in "contact[position]", with: "Pastry Chef"
    fill_in "contact[email]", with: "example@test.com"

    click_button "Create"

    contact = company.contacts.first
    expect(page).to have_current_path company_path(company)
    expect(page).to have_content "#{contact.name} was added as a contact to #{company.name}"
    expect(page).to have_content contact.name
    expect(page).to have_content contact.position
    expect(page).to have_content contact.email
  end
end
