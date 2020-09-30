# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@test.com" }
    password { "Abcd1234"}
    password_confirmation { "Abcd1234" }
  end
end
