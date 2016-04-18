class BillsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bills = Bill.where(user: current_user)
    @bill = Bill.new
  end

  def create
    @bill = Bill.new(bill_params)
    @start_due_date = params[:bill][:start_due_date]
    @bill.next_due_date = @start_due_date
    @bills = Bill.where(user: current_user)

    if @bill.save
      flash[:notice] = "Bill added successfully!"
      redirect_to bills_path
    else
      flash[:error] = @bill.errors.full_messages.join(". ")
      render :index
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
    ).merge(user: current_user)
  end
end
