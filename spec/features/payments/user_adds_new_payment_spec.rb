require 'rails_helper'

feature "authenticated user adds a payment to a bill", js: true do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:bill1) do
    FactoryGirl.create(
      :bill,
      start_due_date: "2016/06/01",
      next_due_date: "2016/07/01",
      user: user1
    )
  end
  let(:payment) do
    FactoryGirl.build(
      :payment,
      date: "2016/06/29",
      amount: "201.87"
    )
  end

  scenario 'authenticated user successfully adds payment from index' do
    sign_in(user1)

    click_on "paid-#{bill1.id}"

    page.execute_script("$('#datepicker-pmt-#{bill1.id}').val('#{payment.date}')")
    fill_in "Amount Paid", with: payment.amount

    expect_no_page_reload do
      click_on "Submit"

      expect(page).to have_content("08/01/16")
    end
  end

  scenario 'authenticated user successfully adds payment from show page' do
    sign_in(user1)

    click_on bill1.nickname
    click_on "Payment"

    page.execute_script("$('#payment_date').val('#{payment.date}')")
    fill_in "Amount Paid", with: payment.amount

    expect_no_page_reload do
      click_on "Submit"

      expect(page).to have_content("08/01/16")
      expect(page).to have_content("06/29/16")
      expect(page).to have_content("$201.87")
    end
  end
end
