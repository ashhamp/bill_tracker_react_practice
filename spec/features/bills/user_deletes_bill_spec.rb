require 'rails_helper'

# [X] As an authenticated user
# I want to delete a bill
# So that I can keep my bill info up to date

feature "authenticated user deletes a bill" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:bill1) { FactoryGirl.create(:bill, user: user1) }
  let!(:bill2) { FactoryGirl.create(:bill, user: user1) }

  scenario "authenticated user deletes bill successfully" do
    sign_in(user1)

    expect(page).to have_content bill1.nickname
    expect(page).to have_content bill2.nickname

    click_on bill1.nickname
    click_on "Delete"

    expect(page).to_not have_content bill1.nickname
    expect(page).to have_content bill2.nickname
    expect(page).to have_content "Bill deleted successfully"

  end
end
