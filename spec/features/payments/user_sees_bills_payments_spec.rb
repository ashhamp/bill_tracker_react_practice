require 'rails_helper'

feature "authenticated user sees a bill's payments", js: true do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:bill1) do
    FactoryGirl.create(
      :bill,
      start_due_date: "2016/04/30",
      next_due_date: "2016/04/30",
      user: user1
    )
  end
  let(:payment1) do
    FactoryGirl.build(
      :payment,
      date: "2016/04/29",
      amount: "100.07"
    )
  end
  let(:payment2) do
    FactoryGirl.build(
      :payment,
      date: "2016/05/29",
      amount: "365.78",
      description: "This is a payment"
    )
  end

  scenario "authenticated user sees bill's payments" do
    sign_in(user1)
    click_on "paid-#{bill1.id}"

    page.execute_script("$('#datepicker-pmt-#{bill1.id}').val('#{payment1.date}')")
    fill_in "Amount Paid", with: payment1.amount
    click_on "payment_submit"

    click_on "paid-#{bill1.id}"

    page.execute_script("$('#datepicker-pmt-#{bill1.id}').val('#{payment2.date}')")
    fill_in "Amount Paid", with: payment2.amount
    fill_in "Description", with: payment2.description
    click_on "payment_submit"

    click_on bill1.nickname

    expect(page).to have_content("04/29/16")
    expect(page).to have_content("05/29/16")
    expect(page).to have_content("06/30/16")
    expect(page).to have_content(payment1.amount)
    expect(page).to have_content(payment2.amount)
    expect(page).to have_content(payment2.description)
  end
end
