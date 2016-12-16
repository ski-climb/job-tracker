require 'rails_helper'

describe "User sees one company" do
  scenario "a user sees a company" do
    company = create(:company)
    job = create(:job, company: company)

    visit company_path(company)

    expect(page).to have_current_path company_jobs_path(company)
    expect(page).to have_content company.name
    expect(page).to have_content job.title
  end
end
