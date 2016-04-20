require 'rails_helper'

feature "authenticated user adds transaction to a bill". js: true do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:bill1) { FactoryGirl.create(:bill, user: user1) }

  scenario 'authenticated user successfully adds a transaction' do
    sign_in(user1)

    click_link bill1.nickname
    click_on "Paid"


    expect(page).to have_content(bill1.nickname)
    expect(page).to have_content(bill1.start_due_date.strftime('%D'))
    expect(page).to have_content(bill1.next_due_date.strftime('%D'))
    expect(page).to_not have_content(bill2.nickname)
    expect(page).to_not have_content(bill3.nickname)
  end
end
