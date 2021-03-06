class PaymentsController < ApplicationController
    before_action :authenticate_user!

  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      if @payment.bill.one_time
        @next_due_date = nil
        @formatted_date = ""
      else
        @next_due_date = new_next_due_date(@payment.bill.next_due_date)
        @formatted_date = @next_due_date.strftime('%D')
      end

      @bill = @payment.bill
      @bill.update_attributes(next_due_date: @next_due_date)
      @payment_date = @payment.date.strftime('%D')
      @payment_amount = format("$%.2f", @payment.amount)
      @total = @bill.payments.sum(:amount)

      render json: {
        payment: @payment,
        next_due_date: @formatted_date,
        payment_date: @payment_date,
        payment_amount: @payment_amount,
        total: format('$%.2f', @total)
      }
    else
      @errors = @payment.errors.full_messages.join(". ")
      render json: { errors: @errors }
    end
  end

  def update
    @payment = Payment.find(params[:id])

    if @payment.update_attributes(payment_params)
      @date = @payment.date.strftime('%D')
      @no_format_date = @payment.date
      @amount = format("$%.2f", @payment.amount)
      @no_format_amount = @payment.amount
      @bill = @payment.bill
      @total = @bill.payments.sum(:amount)

      render json: {
        date: @date,
        amount: @amount,
        description: @payment.description,
        total: format("$%.2f", @total),
        no_format_amount: @no_format_amount,
        no_format_date: @no_format_date,
        message: "Payment updated successfully!"
      }
    else
      @errors = @payment.errors.full_messages.join(". ")
      render json: { errors: @errors }
    end
  end

  def destroy
    @payment = Payment.find_by_id(params[:id])

    if @payment
      @bill = @payment.bill
      @payment.destroy
      respond_to do |format|
        format.html do
          flash[:notice] = "Payment deleted!"
          redirect_to bill_path(@bill)
        end
        format.json do
          if !@bill.payments.empty?
            @total = format('$%.2f', @bill.payments.sum(:amount))
          else
            @total = ""
          end
          render json: { message: "Payment deleted!", total: @total, status: 200 }
        end
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = "Payment not found"
          redirect_to bills_path
        end
        format.json do
          render json: { message: "Payment not found", status: 400 }
        end
      end
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

    Date.new(new_year, new_month, new_day)
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
