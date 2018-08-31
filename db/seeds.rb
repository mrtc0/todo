require 'faker'

3.times do |i|
  User.create(
    email: "user#{i+1}@example.com", # user1 から初めてタスク名と直感的にわかるように
    password: 'Password1234'
  )
end

10.times do |i|
  created_at = Faker::Time.forward.to_datetime
  expire_at = created_at + 2.days
  user_id = Faker::Number.between(0, 2)
  Task.create(
    title:    "タスク#{i} - user#{user_id}",
    description:  "内容#{i}",
    priority: Faker::Number.between(0, 3),
    status: Faker::Number.between(0, 2),
    expire_at: expire_at,
    created_at: created_at,
    user_id: user_id
  )
end
