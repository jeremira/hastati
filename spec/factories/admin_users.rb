# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user do
    sequence(:email) { |n| "admin_#{n}@test.com" }
    password { "Abcd1234"}
    password_confirmation { "Abcd1234" }
  end
end
