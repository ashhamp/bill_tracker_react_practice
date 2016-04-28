class ChartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bills = Bill.where(user: current_user)
    @chart_array = @bills.map { |bill| [bill.nickname, bill.current_month_payments] }

    @chart_array_prior = @bills.map { |bill| [bill.nickname, bill.prior_month_payments] }

    @chart_array_year = @bills.map { |bill| [bill.nickname, bill.past_year_payments] }

  end
end
