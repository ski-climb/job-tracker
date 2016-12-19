require 'rails_helper'

describe "User sees jobs grouped by attribute" do
  scenario "a user sees the count for of jobs at each city" do
    create_list(:job, 4, city: "Denver")
    create_list(:job, 2, city: "Tucson")
    visit dashboard_path

    expect(page).to have_content "Denver"
    expect(page).to have_content "Tucson"
    expect(page).to have_content "4"
    expect(page).to have_content "2"
  end
end
