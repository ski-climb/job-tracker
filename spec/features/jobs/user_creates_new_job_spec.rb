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
    expect(page).to have_content "Category can't be blank"
    expect(Job.count).to eq 0
  end

  scenario "a user can create a new job" do
    category_1, category_2 = create_list(:category, 2)
    company = create(:company, name: "Hasbro")
    visit new_company_job_path(company)

    fill_in "job[title]", with: "Developer"
    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 80
    fill_in "job[city]", with: "Denver"
    select(category_2.title, from: 'Category')
    click_button "Create"

    job = Job.find_by(title: "Developer")

    expect(page).to have_current_path job_path(job)
    expect(page).to have_content "Developer job at Hasbro was successfully created!"
    expect(page).to have_content company.name
    expect(page).to have_content "Developer"
    expect(page).to have_content "80"
    expect(page).to have_content "Denver"
    expect(page).to have_content category_2.title
  end
end
