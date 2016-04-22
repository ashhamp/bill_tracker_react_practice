require 'rails_helper'

feature "authenticated user updates a bill", js: true do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:bill1) { FactoryGirl.create(:bill, user: user1) }

  scenario "authenticated user updates a bill successfully" do
    new_name = "I'm a New Name"
    new_start_date = Date.parse("2016/10/31")
    new_next_due = Date.parse("2016/12/01")
    new_recurring = "204.50"
    new_web = "https://wwww.amazon.com"

    sign_in(user1)
    click_link bill1.nickname

    click_on "Update"

    fill_in "Nickname", with: new_name
    page.execute_script("$('#datepicker-update-start').val('2016/10/31')")
    page.execute_script("$('#datepicker-update-next').val('2016/12/01')")
    fill_in "Recurring Amount", with: new_recurring
    fill_in "Url", with: new_web

    click_on "Submit"

    expect(page).to have_content new_name
    expect(page).to have_content new_start_date.strftime('%D')
    expect(page).to have_content new_next_due.strftime('%D')
    expect(page).to have_content new_recurring
    expect(page).to have_content new_web
    expect(page).to have_content "Bill updated successfully!"

    expect(page).to_not have_content bill1.nickname
    expect(page).to_not have_content bill1.start_due_date.strftime('%D')
    expect(page).to_not have_content bill1.next_due_date.strftime('%D')
    expect(page).to_not have_content bill1.url
  end

  scenario "authenticated user updates bill unsuccessfully" do
    sign_in(user1)
    click_on bill1.nickname
    click_on "Update"
    page.execute_script("$('#datepicker-update-next').val('2014/12/01')")
    click_on "Submit"

    expect(page).to have_content "Next due date must be after"
  end
end
