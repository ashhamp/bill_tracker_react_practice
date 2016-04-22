class PaymentsController < ApplicationController

  def create

    @payment = Payment.new(payment_params)

    if @payment.save
      if @payment.bill.one_time
        @next_due_date = nil
      else
        @next_due_date = new_next_due_date(@payment.bill.next_due_date)
        @formatted_date = Date.parse(@next_due_date).strftime('%D')
      end
      @bill = @payment.bill
      @bill.next_due_date = @next_due_date


      render json: {
        payment: @payment,
        next_due_date: @formatted_date
      }
    else
      @errors = @payment.errors.full_messages.join(". ")
      render json: { errors: @errors }
    end
  end

  private

  def payment_params
    params.require(:payment).permit(
      :date,
      :amount,
      :bill_id,
      :description
    ).merge(user: current_user)
  end

  def new_next_due_date(date)

    new_month = next_month(date.month)
    new_year = next_year(date.month, date.year)
    new_day = ""

    if date.day <= 28 || date.day <= last_day_of_month(new_month, new_year)
      new_day = date.day
    else
      new_day = last_day_of_month(new_month, new_year)
    end

    "#{new_year}/#{new_month}/#{new_day}"
  end

  def last_day_of_month(month, year)
    Date.new(year, month, -1).day
  end

  def next_month(month)
    new_month = nil
    if month < 12
      new_month = month + 1
    else
      new_month = 1
    end
  end

  def next_year(month, year)
    new_year = nil
    if month < 12
      new_year = year
    else
      new_year = year + 1
    end
  end
end
