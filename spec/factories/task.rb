require 'factory_bot'
require 'faker'

FactoryBot.define do
  factory :task do
    title 'タスク1'
    description 'これはテストです'
    expire_at { Faker::Time.forward.to_datetime }
    created_at { Faker::Time.backward.to_datetime }
    priority 1

    factory :user1_task do
      title 'これはユーザー1のタスクです'
    end

    factory :user2_task do
      title 'これはユーザー2のタスクです'
    end

    factory :expire_of_past_task do
      title 'タスク1'
      description 'これは期日が過去の日時のタスクです'
      expire_at { Faker::Time.backward.to_datetime }
      priority 1
    end

    factory :nontitle_task do
      title ''
      description 'これはタイトルがないタスクです'
    end

    factory :priority_is_nil_task do
      title 'タスク1'
      description 'これは優先度がnilなタスクです'
      expire_at { Faker::Time.forward.to_datetime }
      priority nil
    end

    factory :status_is_doing_task do
      title 'doing-task'
      description 'これはstatusがdoingなタスクです'
      priority 1
    end

    factory :status_is_done_task do
      title 'done-task'
      description 'これはstatusがdoneなタスクです'
      priority 1
    end

    factory :priority_is_random_task do
      title '優先度ランダムタスク'
      description 'これは優先度がランダムに設定されるタスクです'
      priority { Faker::Number.between(0, 3) }
    end
  end
end
