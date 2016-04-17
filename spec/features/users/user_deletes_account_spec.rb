require 'rails_helper'

  # [X] As an authenticated user
  # I want to delete my account
  # So that my information is no longer retained by the app

feature "user deletes their account" do
  let!(:user1) { FactoryGirl.create(:user) }

  scenario "user deletes account successfully" do
    sign_in(user1)
    click_on("Update Account")
    click_on "Cancel my account"

    expect(page).to have_content "You need to sign in or sign up before continuing"
  end
end
