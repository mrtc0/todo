require 'factory_bot'
require 'faker'

FactoryBot.define do
  factory :user do
    email 'user@example.com'
    password 'Password1234'

    factory :short_password do
      password 'Pass1'
    end

    factory :no_number_password do
      password 'password'
    end

    factory :no_uppercase_in_password do
      password 'password1234'
    end

    factory :no_lowercase_in_password do
      password 'PASSWORD1234'
    end

    factory :no_letter_in_password do
      password '12345678'
    end
  end
end
