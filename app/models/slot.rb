# frozen_string_literal: true

class Slot < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :guests, through: :bookings, source: :user

  validates :status, presence: true
  validates :scheduled_at, presence: true
  validates :daytime, presence: true
  validates :max_people, presence: true, numericality: { greater_than: 0 }

  enum status: { available: 0, booked: 1, payed: 2 }
  enum daytime: { lunch: 0, dinner: 1 }

  scope :bookable_for, ->(user) { available.where.not(user: user).where('scheduled_at > ?', Time.zone.now) }

  def bookable_for?(user)
    Slot.bookable_for(user).exists? id
  end
end
