require 'rails_helper'

describe "User sees one category" do
  scenario "a user sees a category and all jobs for that category" do
    category = create(:category)
    job_1, job_2, job_3 = create_list(:job, 3, category: category)

    visit category_path(category)

    expect(page).to have_content category.title
    expect(page).to have_content job_1.title
    expect(page).to have_content job_2.title
    expect(page).to have_content job_3.title
  end
end
