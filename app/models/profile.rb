# frozen_string_literal: true

class Profile < ApplicationRecord
  before_validation :downcase_attributes

  belongs_to :user

  def address
    [street, zipcode, city, country].reject(&:blank?).join(', ')
  end

  def fullname
    [firstname, lastname].reject(&:blank?).map(&:capitalize).join(' ')
  end

  private

  #
  # ensure all profile attributes are downcased
  #
  def downcase_attributes
    attributes.each { |_field, value| value.downcase! if value.is_a? String }
  end
end
