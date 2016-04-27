class ChartsController < ApplicationController
  before_action :authenticate_user!

  def completed_tasks
    @bills = Bill.where(user: current_user)
    @payment_array = []
    @bills.each do |bill|
      @payment_array.push(bill.name, bill.payments.pluck(:amount).inject(:+))
    end

  end
end
