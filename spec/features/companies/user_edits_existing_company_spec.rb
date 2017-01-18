require 'rails_helper'

describe "User edits an existing company" do
  scenario "a user sees helpful error messages and nothing is saved to the database when no name provided" do 
    company = create(:company)
    visit companies_path

    within ".company_#{company.id}" do
      click_on "Edit"
    end

    expect(find_field("company[name]").value).to eq company.name

    fill_in "company[name]", with: ""
    click_button "Update"

    expect(page).to have_content "Name can't be blank"
    expect(Company.first.name).to eq company.name
  end

  scenario "a user sees helpful error messages and nothing is saved to the database when a duplicate name is provided" do
    company_1 = create(:company, name: "ESPN")
    company_2 = create(:company)
    visit edit_company_path(company_2)

    expect(find_field("company[name]").value).to eq company_2.name

    fill_in "company[name]", with: "ESPN"
    click_button "Update"

    expect(page).to have_content "Name has already been taken"
    expect(Company.last).not_to eq "ESPN"
  end

  scenario "a user can edit a company" do
    company = create(:company)
    visit edit_company_path(company)

    expect(find_field("company[name]").value).to eq company.name

    fill_in "company[name]", with: "EA Sports"
    click_button "Update"

    expect(page).to have_current_path company_path(company)
    expect(page).to have_content("EA Sports")
    expect(page).to_not have_content(company.name)
  end
end
