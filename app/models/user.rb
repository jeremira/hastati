# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :slots, dependent: :destroy
  has_many :events, class_name: 'Slot', foreign_key: 'guest_id', inverse_of: 'guest', dependent: :destroy

  enum identity: { guest: 0, host: 1 }
end
