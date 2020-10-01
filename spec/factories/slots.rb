# frozen_string_literal: true

FactoryBot.define do
  factory :slot do
    scheduled_at { Time.zone.now }
    daytime { 0 }
    max_people { 2 }
    association :user, factory: :host_user
  end
end
