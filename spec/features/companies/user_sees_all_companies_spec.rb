require 'rails_helper'

describe "User sees all companies" do
  scenario "a user sees all the companies" do
    company_1 = create(:company)
    company_2 = create(:company)

    visit companies_path

    expect(page).to have_content company_2.name
  end

end
