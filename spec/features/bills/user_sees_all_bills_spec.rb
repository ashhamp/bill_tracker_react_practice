require 'rails_helper'

feature "authenticated user sees a list of their bills" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:bill1) { FactoryGirl.create(:bill, user: user1) }
  let!(:bill2) { FactoryGirl.create(:bill, user: user1) }
  let!(:bill3) { FactoryGirl.create(:bill, user: user1) }


  scenario 'user signs in and sees a list of their bills' do
    sign_in(user1)

    expect(page).to have_content(bill1.nickname)
    expect(page).to have_content(bill2.nickname)
    expect(page).to have_content(bill3.nickname)

  end
end
