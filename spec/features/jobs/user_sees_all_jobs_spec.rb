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

  scenario "a user sees all jobs, regardless of company" do
    company_1 = create(:company)
    company_2 = create(:company)
    job_1 = create(:job, company: company_1)
    job_2 = create(:job, company: company_2)

    visit jobs_path

    expect(page).to have_content job_1.title
    expect(page).to have_content job_2.title
  end
end
