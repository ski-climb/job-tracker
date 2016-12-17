require 'rails_helper'

describe "User creates a new category" do
  scenario "a user sees helpful errors and nothing is saved to the database when invalid information is entered" do
    visit new_category_path

    fill_in "category[title]", with: ""
    click_on "Create Category"

    expect(page).to have_content "Title can't be blank"
    expect(Category.count).to eq 0
  end

  scenario "a user can create a category" do
    visit new_category_path

    fill_in "category[title]", with: "Data Science"
    click_on "Create Category"

    category = Category.find_by(title: "Data Science")

    expect(page).to have_current_path category_path(category)
    expect(page).to have_content "Category, Data Science, was successfully created!"
    expect(page).to have_content "Data Science"
    expect(Category.count).to eq 1
  end
end
