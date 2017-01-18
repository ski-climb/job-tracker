require 'rails_helper'

describe "User deletes existing job" do
  scenario "a user can delete a job" do
    company = create(:company)
    job_1, job_2, job_3 = create_list(:job, 3, company: company)
    visit company_path(company)

    within ".job_#{job_2.id}" do
      click_on "Delete"
    end

    expect(page).to have_content "The #{job_2.title} job located in #{job_2.city} was successfully deleted!"
    expect(Job.pluck(:title)).not_to include job_2.title
    expect(Job.count).to eq 2
  end

  scenario "a user can delete a job that has comments" do
    company = create(:company)
    job_1, job_2, job_3 = create_list(:job, 3, company: company)
    create_list(:comment, 3, job: job_2)
    visit company_path(company)

    within ".job_#{job_2.id}" do
      click_on "Delete"
    end

    expect(page).to have_content "The #{job_2.title} job located in #{job_2.city} was successfully deleted!"
    expect(Job.pluck(:title)).not_to include job_2.title
    expect(Job.count).to eq 2
    expect(Comment.count).to eq 0
  end
end
