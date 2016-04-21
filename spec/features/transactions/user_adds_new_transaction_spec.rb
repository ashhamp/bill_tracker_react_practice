require 'rails_helper'

feature "authenticated user adds transaction to a bill", js: true do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:bill1) { FactoryGirl.create(:bill, user: user1) }
  let(:payment) { FactoryGirl.build(:payment) }

  scenario 'authenticated user successfully adds a transaction' do
    sign_in(user1)

    click_on "paid#{bill1.id}"

    page.execute_script("$('#datepicker-paid').val('#{payment.pmt_date}')")
    fill_in "Amount Paid", with: payment.pmt_amt

  expect(page).to have_content("Payment added successfully!")
  end
end
