require 'rails_helper'

describe "User deletes existing job" do
  scenario "a user can delete a job" do
    company = create(:company)
    job_1, job_2, job_3 = create_list(:job, 3, company: company)
    visit company_jobs_path(company)

    within "#job_#{job_2.id}" do
      click_on "Delete"
    end

    expect(page).to have_content "#{job_2.title} was successfully deleted!"
    expect(Job.pluck(:title)).not_to include job_2.title
    expect(Job.count).to eq 2
  end
end
