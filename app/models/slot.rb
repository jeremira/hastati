# frozen_string_literal: true

class Slot < ApplicationRecord
  belongs_to :user

  validates :status, presence: true
  validates :scheduled_at, presence: true
  validates :daytime, presence: true
  validates :max_people, presence: true, numericality: { greater_than: 0 }

  enum status: { available: 0, booked: 1, payed: 2 }
  enum daytime: { lunch: 0, dinner: 1 }
end