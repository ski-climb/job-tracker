require 'rails_helper'

describe "User edits and existing job" do
  scenario "a user sees helpful error messages and nothing is saved to the database when invalid attributes are provided" do
    job = create(:job, title: "Developer")
    visit edit_company_job_path(job.company, job)

    expect(find_field('job[title]').value).to eq job.title
    expect(find_field('job[description]').value).to eq job.description
    expect(find_field('job[level_of_interest]').value.to_i).to eq job.level_of_interest
    expect(find_field('job[city]').value).to eq job.city

    fill_in "job[title]", with: ""
    click_button "Update"

    expect(page).to have_content "Title can't be blank"
    expect(Job.first.title).to eq "Developer"
  end

  scenario "a user can edit a job" do
    job = create(:job, title: "Developer")
    visit edit_company_job_path(job.company, job)

    expect(find_field('job[title]').value).to eq job.title
    expect(find_field('job[description]').value).to eq job.description
    expect(find_field('job[level_of_interest]').value.to_i).to eq job.level_of_interest
    expect(find_field('job[city]').value).to eq job.city

    fill_in "job[title]", with: "NEW TITLE"
    fill_in "job[description]", with: "NEW DESCRIPTION"
    fill_in "job[level_of_interest]", with: 22
    fill_in "job[city]", with: "NEW CITY"
    click_button "Update"

    expect(page).to have_content job.company_name
    expect(page).to have_content "NEW TITLE"
    expect(page).to have_content "NEW DESCRIPTION"
    expect(page).to have_content 22
    expect(page).to have_content "NEW CITY"
  end
end




