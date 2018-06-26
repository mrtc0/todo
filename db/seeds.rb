require 'faker'

10.times do |i|
  created_at = Faker::Time.forward.to_datetime
  expire_at = created_at + 1
  Task.create(
    title:    "タスク#{i}",
    description:  "内容#{i}",
    priority: 1,
    expire_at: expire_at,
    created_at: created_at
  )
end
