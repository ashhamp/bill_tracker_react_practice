class BillsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bills = Bill.where(user: current_user).order(:next_due_date)
    @bill = Bill.new
  end

  def create
    @bill = Bill.new(bill_params)

    @start_due_date = params[:bill][:start_due_date]
    @bill.next_due_date = @start_due_date
    @bills = Bill.where(user: current_user)

    if @bill.save
      respond_to do |format|
        format.html do
          flash.now[:notice] = "Bill added successfully!"
          redirect_to bills_path
        end
        @format_time_start = @bill.start_due_date.strftime('%D')
        @format_time_next = @bill.next_due_date.strftime('%D')
        if @bill.recurring_amt.nil?
          @recurring_amt = "N/A"
        else
          @recurring_amt = format("$%.2f", @bill.recurring_amt)
        end
  
        format.json do
          render json: {
            bill: @bill,
            start_date: @format_time_start,
            next_date: @format_time_next,
            recurring_amt: @recurring_amt
          }
        end
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = @bill.errors.full_messages.join(". ")
          render :index
        end
        @errors = @bill.errors.full_messages.join(". ")
        format.json { render json: { error: @errors } }
      end
    end
  end

  def show

    @bill = Bill.find(params[:id])
  end

  def update
    @bill = Bill.find(params[:id])

    if @bill.update_attributes(bill_params)
      flash[:notice] = "Bill updated successfully!"
      redirect_to bill_path(@bill)
    else
      flash[:error] = @bill.errors.full_messages.join(". ")
      render :show
    end
  end

  private

  def bill_params
    params.require(:bill).permit(
      :nickname,
      :url,
      :start_due_date,
      :recurring_amt,
      :one_time,
      :next_due_date,
    ).merge(user: current_user)
  end
end
