# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Booking, type: :model do
  let(:host) { create :host_user }
  let(:guest) { create :guest_user }
  let(:booking) { build :booking }

  describe 'Validation' do
    it 'has a valid factory' do
      expect(booking).to be_valid
    end
    it 'requires a people count' do
      expect(build(:booking, people: nil)).not_to be_valid
    end
    it 'requires a non zero people count' do
      expect(build(:booking, people: 0)).not_to be_valid
    end
    it 'requires a positive people count' do
      expect(build(:booking, people: 1)).to be_valid
    end
    it 'requires an user' do
      expect(build(:booking, user: nil)).not_to be_valid
    end
    it 'accepts an host as an user' do
      expect(build(:booking, user: host)).to be_valid
    end
    it 'accepts a guest as an user' do
      expect(build(:booking, user: guest)).to be_valid
    end
    it 'requires a slot' do
      expect(build(:booking, slot: nil)).not_to be_valid
    end
  end
end
