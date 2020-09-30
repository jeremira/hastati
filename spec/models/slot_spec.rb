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
end
