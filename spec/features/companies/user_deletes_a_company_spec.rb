require 'rails_helper'

describe "User deletes existing company" do
  scenario "a user can delete a company" do
    company = create(:company)
    visit companies_path

    within(".company_#{company.id}") do
      click_link "Delete"
    end

    expect(page).to have_content("#{company.name} and all associated jobs for #{company.name} were successfully deleted!")
    expect(Company.count).to eq 0
  end

  scenario "a user can delete a company that has jobs" do
    company = create(:company)
    create_list(:job, 2, company: company)
    visit companies_path

    expect(Job.count).to eq 2
    expect(Company.count).to eq 1
    expect(company.jobs.count).to eq 2

    within ".company_#{company.id}" do
      click_on 'Delete'
    end

    expect(page).to have_content("#{company.name} and all associated jobs for #{company.name} were successfully deleted!")
    expect(Job.count).to eq 0
    expect(Company.count).to eq 0
    expect(company.jobs.count).to eq 0
  end
end
