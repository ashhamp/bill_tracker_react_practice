FactoryGirl.define do
  sequence :email do |n|
    "usermcuser#{n}@example.com"
  end

  sequence :username do |n|
    "usermcuser#{n}"
  end

  factory :user do
    username
    email
    password "iamalittlepassword"
  end
end
