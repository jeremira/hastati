# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  def address
    [street, zipcode, city, country].reject(&:blank?).join(', ')
  end

  def fullname
    [firstname, lastname].reject(&:blank?).map(&:capitalize).join(' ')
  end
end
