# frozen_string_literal: true

FactoryBot.define do
  factory :guest_user, class: 'User' do
    sequence(:email) { |index| "guest_#{index}@test.com" }
    password { 'Abcd1234' }
    password_confirmation { 'Abcd1234' }
  end
  factory :host_user, class: 'User' do
    sequence(:email) { |index| "host_#{index}@test.com" }
    password { 'Abcd1234' }
    password_confirmation { 'Abcd1234' }
    identity { 1 }
  end
end
