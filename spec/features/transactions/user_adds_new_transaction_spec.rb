require 'rails_helper'

feature "authenticated user adds transaction to a bill", js: true do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:bill1) do
    FactoryGirl.create(
      :bill,
      start_due_date: "2016/06/01",
      next_due_date: "2016/07/01",
      user: user1
    )
  end
  let(:payment) { FactoryGirl.build(:payment, date: "2016/06/29") }

  scenario 'authenticated user successfully adds a transaction' do
    sign_in(user1)

    click_on "paid-#{bill1.id}"

    page.execute_script("$('#payment_date').val('#{payment.date}')")
    fill_in "Amount Paid", with: payment.amount
    click_on "Submit"

    expect(page).to have_content("08/01/16")
  end
end
