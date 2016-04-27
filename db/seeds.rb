usermcuser = User.find_by(email: "heyeveryone@example.com")
unless usermcuser.present?
  usermcuser = User.create(
    username: "usermcuser",
    email: "heyeveryone@example.com",
    password: "iamalittlepassword",
    password_confirmation: "iamalittlepassword"
)
end

bill1 = Bill.find_or_create_by(
  nickname: "Visa Rewards",
  start_due_date: "2016/04/29",
  next_due_date: "2016/04/29",
  user: usermcuser
)

payment1 = Payment.find_or_create_by(
  date: "2016/04/28",
  amount: "478.55",
  user: usermcuser,
  bill: bill1
)
