# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Slot, type: :model do
  let(:frozen_time) { Time.zone.parse('2020/05/05') }
  let(:host) { create :host_user }
  let(:host2) { create :host_user }
  let(:slot) { build :slot, user: host }

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

  describe '.bookable_for' do
    context 'when user is an host' do
      let(:tested_method) { described_class.bookable_for(host) }
      let(:slot1) { create :slot, user: host2, status: 0, scheduled_at: '2020/05/06' }
      let(:slot2) { create :slot, user: host2, status: 0, scheduled_at: '2020/06/02' }

      before do
        allow(Time).to receive(:now).and_return(frozen_time)
        # Available, other host, futur events
        slot1
        slot2
        # Own host's slots
        create :slot, user: host, status: 0, scheduled_at: '2020/06/02'
        create :slot, user: host, status: 0, scheduled_at: '2020/05/06'
        # Available past events
        create :slot, user: host, status: 0, scheduled_at: '2020/04/05'
        create :slot, user: host2, status: 0, scheduled_at: '2020/05/04'
        # Non-available events
        create :slot, user: host, status: 1, scheduled_at: '2020/04/05'
        create :slot, user: host, status: 1, scheduled_at: '2020/06/05'
        create :slot, user: host2, status: 1, scheduled_at: '2020/06/05'
        create :slot, user: host2, status: 2, scheduled_at: '2020/06/05'
      end

      it 'returns an activerecord relation' do
        expect(tested_method).to be_an ActiveRecord::Relation
      end
      it 'returns 3 elements' do
        expect(tested_method.count).to eq 2
      end
      it 'includes next day event for host 2' do
        expect(tested_method).to include(slot1)
      end
      it 'includes next month event for host 2' do
        expect(tested_method).to include(slot2)
      end
    end

    context 'when user is a guest' do
      let(:guest) { create :guest_user }
      let(:tested_method) { described_class.bookable_for(guest) }
      let(:slot1) { create :slot, user: host2, status: 0, scheduled_at: '2020/05/06' }
      let(:slot2) { create :slot, user: host2, status: 0, scheduled_at: '2020/06/02' }
      let(:slot3) { create :slot, user: host, status: 0, scheduled_at: '2020/06/02' }
      let(:slot4) { create :slot, user: host, status: 0, scheduled_at: '2020/05/06' }

      before do
        allow(Time).to receive(:now).and_return(frozen_time)
        # Available, other host, futur events
        slot1
        slot2
        slot3
        slot4
        # Available past events
        create :slot, user: host, status: 0, scheduled_at: '2020/04/05'
        create :slot, user: host2, status: 0, scheduled_at: '2020/05/04'
        # Non-available events
        create :slot, user: host, status: 1, scheduled_at: '2020/04/05'
        create :slot, user: host, status: 1, scheduled_at: '2020/06/05'
        create :slot, user: host2, status: 1, scheduled_at: '2020/06/05'
        create :slot, user: host2, status: 2, scheduled_at: '2020/06/05'
      end

      it 'returns an activerecord relation' do
        expect(tested_method).to be_an ActiveRecord::Relation
      end
      it 'returns 4 elements' do
        expect(tested_method.count).to eq 4
      end
      it 'includes next day event for host 1' do
        expect(tested_method).to include(slot3)
      end
      it 'includes next month event for host 1' do
        expect(tested_method).to include(slot4)
      end
      it 'includes next day event for host 2' do
        expect(tested_method).to include(slot1)
      end
      it 'includes next month event for host 2' do
        expect(tested_method).to include(slot2)
      end
    end
  end

  describe '#bookable_for?' do
    let(:guest) { create :guest_user }
    let(:slot1) { create :slot, user: host2, status: 0, scheduled_at: '2020/05/06' }
    let(:slot2) { create :slot, user: host2, status: 0, scheduled_at: '2020/06/02' }
    let(:slot3) { create :slot, user: host, status: 0, scheduled_at: '2020/06/02' }
    let(:slot4) { create :slot, user: host, status: 0, scheduled_at: '2020/05/06' }

    before do
      allow(Time).to receive(:now).and_return(frozen_time)
      # Available, other host, futur events
      slot1
      slot2
      slot3
      slot4
      # Available past events
      create :slot, user: host, status: 0, scheduled_at: '2020/04/05'
      create :slot, user: host2, status: 0, scheduled_at: '2020/05/04'
      # Non-available events
      create :slot, user: host, status: 1, scheduled_at: '2020/04/05'
      create :slot, user: host, status: 1, scheduled_at: '2020/06/05'
      create :slot, user: host2, status: 1, scheduled_at: '2020/06/05'
      create :slot, user: host2, status: 2, scheduled_at: '2020/06/05'
    end

    it 'is false for past & non available events for host 1' do
      described_class.where.not(id: [slot1.id, slot2.id, slot3.id, slot4.id]).each do |slot|
        expect(slot.bookable_for?(host)).to be false
      end
    end
    it 'is false for past & non available events for host 2' do
      described_class.where.not(id: [slot1.id, slot2.id, slot3.id, slot4.id]).each do |slot|
        expect(slot.bookable_for?(host2)).to be false
      end
    end
    it 'is false for past & non available events for guest' do
      described_class.where.not(id: [slot1.id, slot2.id, slot3.id, slot4.id]).each do |slot|
        expect(slot.bookable_for?(guest)).to be false
      end
    end
    it 'is true for next day event 1 for different host' do
      expect(slot1.bookable_for?(host)).to be true
    end
    it 'is false for next day event 1 for same host' do
      expect(slot1.bookable_for?(host2)).to be false
    end
    it 'is true for next day event 1 for a guest' do
      expect(slot1.bookable_for?(guest)).to be true
    end
    it 'is true for next month event 2 for different host' do
      expect(slot2.bookable_for?(host)).to be true
    end
    it 'is false for next month event 2 for same host' do
      expect(slot2.bookable_for?(host2)).to be false
    end
    it 'is true for next month event 2 for a guest' do
      expect(slot2.bookable_for?(guest)).to be true
    end
    it 'is true for next day event 3 for different host' do
      expect(slot3.bookable_for?(host2)).to be true
    end
    it 'is false for next day event 3 for same host' do
      expect(slot3.bookable_for?(host)).to be false
    end
    it 'is true for next day event 3 for a guest' do
      expect(slot3.bookable_for?(guest)).to be true
    end
    it 'is true for next month event 4 for different host' do
      expect(slot4.bookable_for?(host2)).to be true
    end
    it 'is false for next month event 4 for same host' do
      expect(slot4.bookable_for?(host)).to be false
    end
    it 'is true for next month event 4 for a guest' do
      expect(slot4.bookable_for?(guest)).to be true
    end
  end
end
