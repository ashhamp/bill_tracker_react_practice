require 'rails_helper'

# [ X] As an authenticated user
# I want to update my information
# So that I can keep my profile up to date

feature "authenticated user updates their profile" do
  let!(:user1) { FactoryGirl.create(:user) }

  scenario "authenticated user updates email successfully" do
    sign_in(user1)
    click_on("Update Account")

    fill_in "Email", with: "updateuser@example.com"
    fill_in "Current password", with: user1.password
    click_on "update-account-button"

    expect(page).to have_content "Your account has been updated successfully."
  end

  scenario "authenticated user updates password successfully" do
    sign_in(user1)
    click_on("Update Account")

    fill_in "Password", with: "iamanewpassword"
    fill_in "Password confirmation", with: "iamanewpassword"
    fill_in "Current password", with: user1.password
    click_on "update-account-button"

    expect(page).to have_content "Your account has been updated successfully."
  end

  scenario "user updates profile unsuccessfully" do
    sign_in(user1)
    click_on("Update Account")

    fill_in "Email", with: "updateuser@example.com"
    click_on "update-account-button"

    expect(page).to have_content "Current password can't be blank"
  end
end
