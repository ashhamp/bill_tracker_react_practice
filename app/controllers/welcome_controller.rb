class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to bills_path
    end
  end
end
