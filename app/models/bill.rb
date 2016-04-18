class Bill < ActiveRecord::Base
  belongs_to :user

  validates :nickname, presence: true
  validates :start_due_date, presence: true
  validates :user, presence: true
  validates_uniqueness_of :nickname, scope: :user_id, case_sensitive: false, message: "already exists"
  validate :start_due_date_cannot_be_in_the_past
  validate :start_due_date_is_not_fixnum


  def start_due_date_is_not_fixnum
    if start_due_date.present? && start_due_date.is_a?(Fixnum)
      errors.add(:start_due_date, "must be a valid date format: yyyy/mm/dd or mm/dd/yyyy")
    end
  end

  def start_due_date_cannot_be_in_the_past
    if start_due_date.is_a?(Date) && start_due_date < Date.today
      errors.add(:start_due_date, "can't be in the past")
    end
  end
end
