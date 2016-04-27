class Bill < ActiveRecord::Base
  belongs_to :user
  has_many :payments

  validates :nickname, presence: true
  validates :start_due_date, presence: true
  validates :user, presence: true
  validates_uniqueness_of :nickname, scope: :user_id, case_sensitive: false, message: "already exists"
  validates_date :next_due_date, :after => :today, allow_nil: true
  validates_date :start_due_date, :after => :today

  def grouped_payments
    payments.group_by_month(:date, format: "%b %Y").sum(:amount)
  end

  def self.monthly_payment
  joins(:payments).merge( Payment.date )
  end
end
