require 'factory_bot'
require 'faker'

FactoryBot.define do
  factory :task do
    title 'タスク1'
    description 'これはテストです'
    expire_at { Faker::Time.forward.to_datetime }
    created_at { Faker::Time.backward.to_datetime }
    priority 1
  end
end
