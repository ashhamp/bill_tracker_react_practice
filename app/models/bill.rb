class Bill < ActiveRecord::Base
  belongs_to :user

  validates :nickname, presence: true
  validates :start_due_date, presence: true
  validates :user, presence: true
  validates_uniqueness_of :nickname, scope: :user_id, case_sensitive: false, message: "already exists"
  validates_date :next_due_date, :after => lambda { Date.current }
  validates_date :start_due_date, :after => lambda { Date.current }
end
