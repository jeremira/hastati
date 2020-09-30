# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Slot, type: :model do
  let(:slot) { build :slot }

  describe 'Validation' do
    it 'has a valid factory' do
      expect(slot).to be_valid
    end
    it 'requires an user' do
      expect(build(:slot, user: nil)).not_to be_valid
    end
    it 'requires a status' do
      expect(build(:slot, status: nil)).not_to be_valid
    end
    it 'requires a scheduled_at timestamp' do
      expect(build(:slot, scheduled_at: nil)).not_to be_valid
    end
    it 'requires a daytime timestamp' do
      expect(build(:slot, daytime: nil)).not_to be_valid
    end
    it 'requires a max people amount' do
      expect(build(:slot, max_people: nil)).not_to be_valid
    end
    it 'requires a max people greater than 0' do
      expect(build(:slot, max_people: 0)).not_to be_valid
    end
  end

  describe 'Status enum' do
    let(:slot) { create :slot }

    it 'default to available status' do
      expect(slot.available?).to eq true
    end
    it 'accept booked status' do
      slot.booked!
      expect(slot.booked?).to eq true
    end
    it 'accept payed status' do
      slot.payed!
      expect(slot.payed?).to eq true
    end
  end

  describe 'Daytime enum' do
    let(:slot) { create :slot }

    it 'default to lunch daytime' do
      expect(slot.lunch?).to eq true
    end
    it 'accept dinner status' do
      slot.dinner!
      expect(slot.dinner?).to eq true
    end
  end
end
