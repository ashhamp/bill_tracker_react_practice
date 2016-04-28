class Bill < ActiveRecord::Base
  belongs_to :user
  has_many :payments

  validates :nickname, presence: true
  validates :start_due_date, presence: true
  validates :user, presence: true
  validates_uniqueness_of :nickname, scope: :user_id, case_sensitive: false, message: "already exists"
  validates_date :next_due_date, :after => :today, allow_nil: true
  validates_date :start_due_date, :after => :today

  def current_month_payments
    @first_day = Date.today.beginning_of_month
    @last_day = Date.today.end_of_month
    @big_dec = payments.where('date >= ? AND date <= ?', @first_day, @last_day).sum(:amount)
    format('%.2f', @big_dec)
  end

  def past_year_payments
    @first_day = Date.today.beginning_of_year
    @last_day = Date.today.end_of_year
    @big_dec = payments.where('date >= ? AND date <= ?', @first_day, @last_day).sum(:amount)
    format('%.2f', @big_dec)
  end

  def prior_month_payments
    @first_day = Date.today.beginning_of_month - 1.month
    @last_day = @first_day.end_of_month
    @big_dec = payments.where('date >= ? AND date <= ?', @first_day, @last_day).sum(:amount)
    format('%.2f', @big_dec)
  end


end
