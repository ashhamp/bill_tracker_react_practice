class BillsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bills = Bill.where(user: current_user).order(:next_due_date)
    @bill = Bill.new
    @payment = Payment.new
  end

  def create
    @bill = Bill.new(bill_params)

    @start_due_date = params[:bill][:start_due_date]
    @bill.next_due_date = @start_due_date
    @bills = Bill.where(user: current_user)

    if @bill.save
      flash.now[:notice] = "Bill added successfully!"
    else
      flash[:error] = @bill.errors.full_messages.join(". ")
    end
      redirect_to bills_path
  end

  def show
    if verified_creator(current_user)
      @bill = Bill.find(params[:id])
      @payments = @bill.payments.order(created_at: :desc)
      @total = @payments.pluck(:amount).inject(:+)
      @payment = Payment.new
    else
      redirect_to bills_path
    end
  end

  def update
    @bill = Bill.find(params[:id])
    @payments = @bill.payments
    @total = @payments.pluck(:amount).inject(:+)
    @payment = Payment.new

    if @bill.update_attributes(bill_params)
      flash[:notice] = "Bill updated successfully!"
      redirect_to bill_path(@bill)
    else
      flash[:error] = @bill.errors.full_messages.join(". ")
      render :show
    end
  end

  def destroy
    @bill = Bill.find(params[:id])

    if @bill.destroy!
      flash[:notice] = "Bill deleted successfully"
    else
      flash[:error] = "Bill could not be found"
    end
    redirect_to bills_path
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

  def verified_creator(user)
    if user == current_user && user == Bill.find(params[:id]).user
      true
    else
      false
    end
  end
end
