require 'rails_helper'

# [X] As an authenticated user
# I want to sign out
# So that no one else can view or add to my account

feature "user signs out" do
  let(:user1) { FactoryGirl.create(:user) }

  scenario "user enters valid sign in information and then signs out" do
    sign_in(user1)

    click_on("Sign Out")
    
    expect(page).to have_content "You need to sign in or sign up before continuing"
  end
end
