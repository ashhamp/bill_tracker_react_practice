require 'rails_helper'

feature "authenticated users sees show page for specific bill" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:bill1) { FactoryGirl.create(:bill, user: user1) }
  let!(:bill2) { FactoryGirl.create(:bill, user: user1) }
  let!(:bill3) { FactoryGirl.create(:bill, user: user1) }

  scenario 'authenticated user navigates to bill show page' do
    sign_in(user1)

    click_link bill1.nickname

    expect(page).to have_content(bill1.nickname)
    expect(page).to have_content(bill1.start_due_date.strftime('%D'))
    expect(page).to have_content(bill1.next_due_date.strftime('%D'))
    expect(page).to_not have_content(bill2.nickname)
    expect(page).to_not have_content(bill3.nickname)
  end
end
