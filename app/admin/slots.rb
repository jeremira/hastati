# frozen_string_literal: true

ActiveAdmin.register Slot do
  includes :user
  permit_params :status, :scheduled_at, :daytime, :max_people
end
