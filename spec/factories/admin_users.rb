# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user do
    sequence(:email) { |index| "admin_#{index}@test.com" }
    password { 'Abcd1234' }
    password_confirmation { 'Abcd1234' }
  end
end
