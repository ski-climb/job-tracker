require 'rails_helper'

describe "User creates a new company" do
  scenario "a user sees helpful error messages and nothing is saved to the database when no name provided" do
    visit new_company_path

    fill_in "company[name]", with: ""
    click_button "Create"

    expect(page).to have_content "Name can't be blank"
    expect(Company.count).to eq(0)
  end

  scenario "a user sees helpful error messages and nothing is saved to the database when a duplicate name is provided" do
    create(:company, name: "ESPN")
    visit new_company_path

    fill_in "company[name]", with: "ESPN"
    click_button "Create"

    expect(page).to have_content "Name has already been taken"
    expect(Company.count).to eq(1)
  end

  scenario "a user can create a new company" do
    visit new_company_path

    fill_in "company[name]", with: "ESPN"
    click_button "Create"

    company = Company.find_by(name: "ESPN")

    expect(page).to have_current_path company_jobs_path(company)
    expect(page).to have_content("ESPN")
    expect(Company.count).to eq(1)
  end
end
