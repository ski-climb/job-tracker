require 'rails_helper'

describe "User sees sorted list of jobs" do
  scenario "a user sees jobs sorted by level of interest" do
    create_list(:job, 4)
    high_level_of_interest_job = create(:job, level_of_interest: 1000)
    low_level_of_interest_job = create(:job, level_of_interest: 1)
    visit root_path
    click_on 'jobs by interest'

    within "tbody tr:first" do
      expect(find(:css, 'td:first').text).to eq high_level_of_interest_job.title
    end
    within "tbody tr:last" do
      expect(find(:css, 'td:first').text).to eq low_level_of_interest_job.title
    end
    expect(Job.count).to eq 6
  end

  scenario "a user sees jobs sorted by location" do
    tucson_job_1 = create(:job, city: "Tucson", title: "Tucson Job")
    denver_job   = create(:job, city: "Denver", title: "Denver Job")
    tucson_job_2 = create(:job, city: "Tucson", title: "Tucson Job")
    visit root_path
    click_on 'jobs by location'

    within "tbody tr:first" do
      expect(find(:css, 'td:first').text).to eq "Denver Job"
    end
    within "tbody tr:last" do
      expect(find(:css, 'td:first').text).to eq "Tucson Job"
    end
    expect(Job.count).to eq 3
  end
end
