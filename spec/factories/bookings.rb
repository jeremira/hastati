# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    people { 2 }
    user
    slot
  end
end
