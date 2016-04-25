require 'rails_helper'

feature "authenticated user updates a payment", js: true do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:bill1) do
    FactoryGirl.create(
      :bill,
      start_due_date: "2016/06/01",
      next_due_date: "2016/07/01",
      user: user1
    )
  end
  let!(:payment1) do
    FactoryGirl.create(
      :payment,
      date: "2016/06/29",
      amount: "201.87",
      user: user1,
      bill: bill1
    )
  end

  scenario 'authenticated user successfully updates a payment' do
    sign_in(user1)

    click_on bill1.nickname
    sleep(5)
    expect(page).to have_content "06/29/16"
    click_on "update-#{payment1.id}"

    page.execute_script("$('#datepicker-update-payment').val('2016/06/30')")

    expect_no_page_reload do
      click_on "Submit"

      expect(page).to have_content("06/30/16")
      expect(page).to_not have_content "06/29/16"
    end
  end

  scenario 'authenticated user unsuccessfully updates a payment' do
    sign_in(user1)

    click_on bill1.nickname
    sleep(5)
    expect(page).to have_content "06/29/16"
    click_on "update-#{payment1.id}"

    page.execute_script("$('#datepicker-update-payment').val('')")

    expect_no_page_reload do
      click_on "Submit"

      expect(page).to have_content("Date can't be blank")
    end
  end
end
