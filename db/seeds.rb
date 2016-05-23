usermcuser = User.find_by(email: "heyeveryone@example.com")
unless usermcuser.present?
  usermcuser = User.create(
    username: "usermcuser",
    email: "usermcuser@example.com",
    password: "password",
    password_confirmation: "password"
  )
end

bill1 = Bill.find_or_create_by(
  nickname: "Visa Rewards",
  start_due_date: "2016/05/29",
  next_due_date: "2016/05/29",
  user: usermcuser
)

payment1 = Payment.find_or_create_by(
  date: "2016/05/28",
  amount: "478.55",
  user: usermcuser,
  bill: bill1
)
