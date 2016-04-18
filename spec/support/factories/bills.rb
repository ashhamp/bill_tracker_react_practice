FactoryGirl.define do

  sequence :nickname do |n|
    "credit card #{n}"
  end

  factory :bill do
    nickname
    url "https://www.creditcard.com"
    start_due_date "2016/05/16"
    association :user, factory: :user
  end
end
