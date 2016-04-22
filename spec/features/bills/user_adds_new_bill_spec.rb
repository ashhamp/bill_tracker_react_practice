require 'rails_helper'

feature "authenticated user adds a new bill", js: true do
  let!(:user1) { FactoryGirl.create(:user) }
  let(:bill1) { FactoryGirl.build(:bill) }

  scenario 'authenticated user successfully adds a bill' do

    sign_in(user1)

    expect(page).to_not have_content bill1.nickname

    click_on "Add Bill"
    fill_in "Nickname", with: bill1.nickname
    fill_in "Url", with: bill1.url
    page.execute_script("$('#datepicker-bill').val('2016/09/01')")
    fill_in "Recurring Amount", with: "100.45"

    expect_no_page_reload do
      click_on "Submit"

      expect(page).to have_content bill1.nickname
      expect(page).to have_content "09/01/16"
      expect(page).to have_content bill1.recurring_amt
    end
  end

  scenario 'authenticated user tries to submit a blank form' do

    sign_in(user1)

    click_on "Add Bill"

    expect_no_page_reload do
      click_on "Submit"

      expect(page).to have_content "Nickname can't be blank"
      expect(page).to have_content "Start due date can't be blank"
    end
  end

  scenario 'authenticated user tries to submit an incomplete form' do

    sign_in(user1)

    click_link "Add Bill"
    fill_in "Nickname", with: bill1.nickname
    fill_in "Url", with: bill1.url

    expect_no_page_reload do
      click_on "Submit"

      expect(page).to have_content "Start due date can't be blank"
    end
  end

  scenario 'authenticated user tries to submit an invalid start date' do

    sign_in(user1)

    click_link "Add Bill"
    fill_in "Nickname", with: bill1.nickname
    fill_in "Url", with: bill1.url
    fill_in "datepicker-bill", with: "2014/09/01"
    fill_in "Recurring Amount", with: "100.45"

    expect_no_page_reload do
      link = find_by_id("bill_submit")
      link.trigger('click')
      expect(page).to have_content "Start due date must be after"
    end
  end
end
