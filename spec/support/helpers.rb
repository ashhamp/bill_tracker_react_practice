module Helpers
  def sign_in(user)
    visit root_path
    click_on "Sign In"

    within("div#signin-form", visible: false) do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_on("sign-in-button")
    end
  end

  def expect_no_page_reload
    page.evaluate_script "$(document.body).addClass('not-reloaded')"
    yield
    expect(page).to have_selector("body.not-reloaded"), "Page should not be reloaded"
  end
end
