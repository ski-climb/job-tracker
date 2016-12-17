require 'rails_helper'

describe "User edits an existing category" do
  scenario "a user sees helpful error messages and nothing is saved to the database when no title provided" do 
    category = create(:category)
    visit categories_path

    within "#category_#{category.id}" do
      click_on "Edit"
    end

    expect(find_field("category[title]").value).to eq category.title

    fill_in "category[title]", with: ""
    click_button "Update"

    expect(page).to have_content "Title can't be blank"
    expect(Category.first.title).to eq category.title
  end

  scenario "a user sees helpful error messages and nothing is saved to the database when a duplicate title is provided" do
    category = create(:category, title: "Data Science")
    category_2 = create(:category)
    visit edit_category_path(category_2)

    expect(find_field("category[title]").value).to eq category_2.title

    fill_in "category[title]", with: "Data Science"
    click_button "Update"

    expect(page).to have_content "Title has already been taken"
    expect(Category.last).not_to eq "Data Science"
  end

  scenario "a user can edit a category" do
    category = create(:category)
    visit edit_category_path(category)

    expect(find_field("category[title]").value).to eq category.title

    fill_in "category[title]", with: "FinTech"
    click_button "Update"

    expect(page).to have_current_path category_path(category)
    expect(page).to have_content("FinTech")
    expect(page).to_not have_content(category.title)
  end
end
