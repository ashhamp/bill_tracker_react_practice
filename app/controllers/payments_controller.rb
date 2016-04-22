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
      @bill.update_attributes(next_due_date: @next_due_date)

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
    if month < 12
      month += 1
    else
      month = 1
    end
    month
  end

  def next_year(month, year)
    if month < 12
      year = year
    else
      year += 1
    end
    year
  end
end
