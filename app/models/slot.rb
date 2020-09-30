# frozen_string_literal: true

class Slot < ApplicationRecord
  belongs_to :user

  validates :status, presence: true
  validates :scheduled_at, presence: true
  validates :daytime, presence: true
  validates :max_people, presence: true, numericality: { greater_than: 0 }
end
