require 'rails_helper'

feature "authenticated user deletes a payment", js: true do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:bill1) do
    FactoryGirl.create(
      :bill,
      start_due_date: "2016/06/01",
      next_due_date: "2016/07/01",
      user: user1
    )
  end
  let!(:bill2) { FactoryGirl.create(:bill, user: user1) }
  let!(:payment1) { FactoryGirl.create(:payment, user: user1, bill: bill1) }
  let!(:payment2) do
    FactoryGirl.create(
      :payment,
      date: "2016/06/29",
      amount: "201.87",
      bill: bill1,
      user: user1
    )
  end

  scenario 'authenticated user deletes payment' do
    sign_in(user1)

    click_on bill1.nickname

    expect(page).to have_content "06/29/16"
    expect(page).to have_content payment2.amount

    click_on "delete-#{payment2.id}"

    expect(page).to_not have_content "06/29/16"
    expect(page).to_not have_content payment2.amount
  end
end
