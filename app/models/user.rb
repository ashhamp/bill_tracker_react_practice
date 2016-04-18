class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bills

  validates :username, presence: true, uniqueness: {
    case_sensitive: false
  }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
