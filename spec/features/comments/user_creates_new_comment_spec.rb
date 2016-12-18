require 'rails_helper'

describe "User creates a new comment" do
  scenario "a user sees helpful errors and nothing is saved to the database when invalid information is entered" do
    job = create(:job)
    visit job_path(job)

    fill_in "comment[content]", with: ""
    click_button "Create"

    expect(page).to have_content "Comment can't be blank"
    expect(Comment.count).to eq 0
  end

  scenario "a user can create a new comment" do
    job = create(:job)
    visit job_path(job)

    fill_in "comment[content]", with: "I think this one is going to pan out."
    click_button "Create"

    comment = job.comments.first
    expect(page).to have_current_path job_path(job)
    expect(page).to have_content "Comment was successfully created!"
    expect(page).to have_content comment.content
  end
end
