class PaymentsController < ApplicationController

  def create
    @user = current_user
    @payment = Payment.new(payment_params)
    if @payment.save
      @next_due_date = new_next_due_date(@payment.bill.next_due_date)
      @bill = @payment.bill
      @bill.next_due_date = @next_due_date
      render json: {
        payment: @payment,
        next_due_date: @next_due_date
      }
    else
      @errors = @payment.errors.full_messages.join(". ")
      render json: { errors: @errors }
    end
  end

  private

  def payment_params
    params.require(:payment).permit(
      :pmt_date,
      :pmt_amount,
      :bill_id
    ).merge(user: current_user)
  end

  def new_next_due_date(date)
    old_date = Date.parse(date)
    new_month = next_month(old_date.month)
    new_year = next_year(old_date.month, old_date.year)
    new_day = ""

    if old_date.day <= 28 || old_date.day <= last_day_of_month(new_month, new_year)
      new_day = old_date.day
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
