require 'rails_helper'

describe "User sees all jobs" do
  scenario "a user sees all the jobs for a specific company" do
    company = create(:company)
    job_1, job_2 = create_list(:job, 2, company: company)

    visit company_path(company)

    expect(page).to have_content company.name
    expect(page).to have_content job_1.title
    expect(page).to have_content job_2.title
  end
end
