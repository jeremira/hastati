# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Slot, type: :model do
  let(:frozen_time) { Time.zone.parse('2020/05/05') }
  let(:host1) { create :host_user }
  let(:host2) { create :host_user }
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

  describe '.bookable' do
    let(:tested_method) { described_class.bookable }
    let(:slot1) { create :slot, user: host, status: 0, scheduled_at: '2020/05/06' }
    let(:slot2) { create :slot, user: host, status: 0, scheduled_at: '2020/06/02' }
    let(:slot3) { create :slot, user: host2, status: 0, scheduled_at: '2020/05/09' }

    before do
      allow(Time).to receive(:now).and_return(frozen_time)
      # Available futur events
      slot1
      slot2
      slot3
      # Available past events
      create :slot, user: host, status: 0, scheduled_at: '2020/04/05'
      create :slot, user: host2, status: 0, scheduled_at: '2020/05/04'
      # Non-available events
      create :slot, user: host, status: 1, scheduled_at: '2020/04/05'
      create :slot, user: host, status: 1, scheduled_at: '2020/06/05'
      create :slot, user: host2, status: 1, scheduled_at: '2020/06/05'
      create :slot, user: host, status: 2, scheduled_at: '2020/06/05'
    end

    it 'returns an activerecord relation' do
      expect(tested_method).to be_an ActiveRecord::RelationShip
    end
    it 'returns 3 elements' do
      expect(tested_method.count).to eq 3
    end
    it 'includes next day event for host 1' do
      expect(tested_method).to include(slot1)
    end
    it 'includes next month event for host 1' do
      expect(tested_method).to include(slot2)
    end
    it 'includes futur event for host 2' do
      expect(tested_method).to include(slot3)
    end
  end
end
