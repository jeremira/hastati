# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :slot

  validates :people, presence: true, numericality: { greater_than: 0 }
end
