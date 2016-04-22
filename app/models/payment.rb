class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :bill

  validates :date, presence: true
  validates_date :date
  validates :amount, presence: true, numericality: true
  validates :user, presence: true
  validates :bill, presence: true
end
