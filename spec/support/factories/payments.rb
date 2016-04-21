FactoryGirl.define do

  factory :payment do
    pmt_date "2016/04/21"
    pmt_amt "205.36"
    association :bill, factory: :bill
    association :user, factory: :user
  end
end
