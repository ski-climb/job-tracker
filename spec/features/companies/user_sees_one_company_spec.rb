require 'rails_helper'

describe "User sees one company" do
  scenario "a user sees a company and all jobs for that company" do
    company = create(:company)
    job_1, job_2, job_3 = create_list(:job, 3, company: company)

    visit company_path(company)

    expect(page).to have_current_path company_path(company)
    expect(page).to have_content company.name
    expect(page).to have_content job_1.title
    expect(page).to have_content job_2.title
    expect(page).to have_content job_3.title
  end
end
