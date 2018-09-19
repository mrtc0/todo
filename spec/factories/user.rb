require 'factory_bot'
require 'faker'

FactoryBot.define do
  # Valid
  factory :user1, class: User do
    email 'user1@example.com'
    password 'Password1234'

    after(:create) do |user|
      FactoryBot.create_list(:user1_task, 3, user: user)
      FactoryBot.create_list(:status_is_doing_task, 3, user: user)
      FactoryBot.create_list(:status_is_done_task, 3, user: user)
    end

    # Valid
    factory :user2 do
      email 'user2@example.com'
      after(:create) do |user|
        create_list(:user2_task, 3, user: user)
      end
    end

    # Invalid
    factory :short_password do
      password 'Pass1'
    end

    # Invalid
    factory :no_number_password do
      password 'password'
    end

    # Invalid
    factory :no_uppercase_in_password do
      password 'password1234'
    end

    # Invalid
    factory :no_lowercase_in_password do
      password 'PASSWORD1234'
    end

    # Invalid
    factory :no_letter_in_password do
      password '12345678'
    end

    # Invalid
    factory :invalid_email do
      email 'email.com'
    end

    factory :admin do
      email 'amdin@example.com'
      admin true
    end
  end
end
