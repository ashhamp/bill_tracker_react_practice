class Api::BillsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bills = Bill.where(user: current_user).order(:next_due_date)
    @bills_formatted = @bills.map do |bill|
      next_due_date = nil
      recurring_amt = nil
      url = nil

      if bill.next_due_date
        next_due_date = bill.next_due_date.strftime('%D')
      end

      if bill.recurring_amt
        recurring_amt = format("$%.2f", bill.recurring_amt)
      end

      if bill.url
        url = bill.url
      end

       { id: bill.id, nickname: bill.nickname, start_due_date: bill.start_due_date.strftime('%D'), next_due_date: next_due_date, recurring_amt: recurring_amt, url: url }
     end

    render json: @bills_formatted
  end


end
