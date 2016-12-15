require 'rails_helper'

describe "User edits an existing company" do
  scenario "a user sees helpful error messages and nothing is saved to the database when no name provided" do
    company = Company.create!(name: "ESPN")
    visit edit_company_path(company)

    expect(find_field("company[name]").value).to eq "ESPN"

    fill_in "company[name]", with: ""
    click_button "Update"

    expect(page).to have_content "Name can't be blank"
    expect(company.name).to eq "ESPN"
  end

  scenario "a user sees helpful error messages and nothing is saved to the database when a duplicate name is provided" do
    company_1 = Company.create!(name: "ESPN")
    company_2 = Company.create!(name: "EA Sports")
    visit edit_company_path(company_2)

    expect(find_field("company[name]").value).to eq "EA Sports"

    fill_in "company[name]", with: "ESPN"
    click_button "Update"

    expect(page).to have_content "Name has already been taken"
    expect(company_2.name).to eq "EA Sports"
  end

  scenario "a user can edit a company" do
    company = Company.create!(name: "ESPN")
    visit edit_company_path(company)

    expect(find_field("company[name]").value).to eq "ESPN"

    fill_in "company[name]", with: "EA Sports"
    click_button "Update"

    expect(page).to have_current_path company_jobs_path(company)
    expect(page).to have_content("EA Sports")
    expect(page).to_not have_content("ESPN")
  end
end
