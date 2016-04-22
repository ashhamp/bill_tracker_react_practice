FactoryGirl.define do

  factory :payment do
    date "2016/04/21"
    amount "205.36"
    association :bill, factory: :bill
    association :user, factory: :user
  end
end
