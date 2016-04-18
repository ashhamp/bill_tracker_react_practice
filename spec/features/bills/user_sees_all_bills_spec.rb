require 'rails_helper'

feature "authenticated user sees a list of their bills" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:bill1) { FactoryGirl.create(:bill, user: user1) }
  let!(:bill2) { FactoryGirl.create(:bill, user: user1) }
  let!(:bill3) { FactoryGirl.create(:bill, user: user1) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:bill4) { FactoryGirl.create(:bill, user: user2) }

  scenario 'user signs in and sees a list of their bills' do
    sign_in(user1)

    expect(page).to have_content(bill1.nickname)
    expect(page).to have_content(bill2.nickname)
    expect(page).to have_content(bill3.nickname)
    expect(page).to_not have_content(bill4.nickname)
  end

  scenario 'unauthenticated user tries to see list of their bills' do
    visit bills_path
    expect(page).to have_content(
      "You need to sign in or sign up before continuing"
    )
  end
end
