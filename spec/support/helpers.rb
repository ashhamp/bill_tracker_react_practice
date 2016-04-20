module Helpers
  def sign_in(user)
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on("sign-in-button")
  end

  def expect_no_page_reload
    page.evaluate_script "$(document.body).addClass('not-reloaded')"
    yield
    expect(page).to have_selector("body.not-reloaded"), "Page should not be reloaded"
  end
end
