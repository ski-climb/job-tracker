require 'rails_helper'

describe "User deletes existing category" do
  scenario "a user can delete a category" do
    category = create(:category)
    visit categories_path

    within(".category_#{category.id}") do
      click_link "Delete"
    end

    expect(page).to have_content("#{category.title} and all associated jobs for #{category.title} were successfully deleted!")
    expect(Category.count).to eq 0
  end

  scenario "a user can delete a category that has jobs" do
    category = create(:category)
    create_list(:job, 2, category: category)
    visit categories_path

    expect(Job.count).to eq 2
    expect(Category.count).to eq 1
    expect(category.jobs.count).to eq 2

    within ".category_#{category.id}" do
      click_on 'Delete'
    end

    expect(page).to have_content("#{category.title} and all associated jobs for #{category.title} were successfully deleted!")
    expect(Job.count).to eq 0
    expect(Category.count).to eq 0
    expect(category.jobs.count).to eq 0
  end
end
