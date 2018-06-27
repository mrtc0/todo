require 'factory_bot'

FactoryBot.define do
  factory :task do
    title 'タスク1'
    description 'これはテストです'
    expire_at '2019-01-01 00:00:00'
    priority 1
  end
end
