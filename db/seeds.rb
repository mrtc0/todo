require 'faker'

50.times do |i|
  created_at = Faker::Time.forward.to_datetime
  expire_at = created_at + 2.days
  Task.create(
    title:    "タスク#{i}",
    description:  "内容#{i}",
    priority: Faker::Number.between(0, 3),
    status: Faker::Number.between(0, 2),
    expire_at: expire_at,
    created_at: created_at
  )
end
