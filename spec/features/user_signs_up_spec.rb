require 'rails_helper'

# [X] As a prospective user
# I want to create an account
# So that I can add bills and keep track of them

feature "user authentication" do
  let(:user1) { FactoryGirl.create(:user) }

  scenario "prospective user enters valid data to create account" do
    visit new_user_registration_path

    fill_in "Username", with: "UserMcUser"
    fill_in "Email", with: "usermcuser@example.com"
    fill_in "Password", with: "bestuserever"
    fill_in "Password confirmation", with: "bestuserever"

    click_on "Create Account"

    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario "prospective user enters invalid data to create account" do
    visit new_user_registration_path

    fill_in "Username", with: "UserMcUser"
    fill_in "Password", with: "bestuserever"
    fill_in "Password confirmation", with: "ihatepasswords"
    click_on "Create Account"

    expect(page).to_not have_content "Welcome! You have signed up successfully."
    expect(page).to have_content "confirmation doesn't match Password"
    expect(page).to have_content "Email can't be blank"
  end

  scenario "authenticated user is not redirected to sign up page" do

    sign_in(user1)
    visit root_path
    expect(page).to_not have_content "Sign Up"
  end
end
