require 'rails_helper'

describe "User creates a new job" do
  scenario "a user sees helpful errors and nothing is saved to the database when invalid information is entered" do
    company = create(:company)
    visit new_company_job_path(company)

    fill_in "job[title]", with: ""
    fill_in "job[level_of_interest]", with: ""
    fill_in "job[city]", with: ""

    click_button "Create"

    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Level of interest can't be blank"
    expect(page).to have_content "City can't be blank"
    expect(Job.count).to eq 0
  end

  scenario "a user can create a new job" do
    company = create(:company)
    visit new_company_job_path(company)

    fill_in "job[title]", with: "Developer"
    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 80
    fill_in "job[city]", with: "Denver"

    click_button "Create"

    job = Job.find_by(title: "Developer")

    expect(page).to have_current_path company_job_path(company, job)
    expect(page).to have_content company.name
    expect(page).to have_content "Developer"
    expect(page).to have_content "80"
    expect(page).to have_content "Denver"
  end
end
