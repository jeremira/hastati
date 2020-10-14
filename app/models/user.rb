# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :slots, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :events, through: :bookings, source: :slot, inverse_of: 'guest'

  enum identity: { guest: 0, host: 1 }
end
