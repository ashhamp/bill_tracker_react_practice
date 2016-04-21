class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :bill

  validates :pmt_date, presence: true
  validates_date :pmt_date
  validates :pmt_amt, presence: true, numericality: true
  validates :user, presence: true
  validates :bill, presence: true
end
