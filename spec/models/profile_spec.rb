# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:profile) { build :profile }

  describe 'Validation' do
    it 'has a valid factory' do
      expect(profile).to be_valid
    end
  end

  describe '#fullname' do
    let(:tested_method) { profile.fullname }

    context 'without any name informations' do
      it 'returns an empty string' do
        expect(tested_method).to eq ''
      end
    end

    context 'with partial name informations' do
      let(:profile) { build :profile, lastname: 'bidule'}

      it 'returns correct address' do
        expect(tested_method).to eq 'Bidule'
      end
    end

    context 'with full name informations' do
      let(:profile) { build :profile, firstname: 'machin', lastname: 'bidule'}

      it 'returns correct address' do
        expect(tested_method).to eq 'Machin Bidule'
      end
    end
  end

  describe '#address' do
    let(:tested_method) { profile.address }

    context 'without any address informations' do
      it 'returns an empty string' do
        expect(tested_method).to eq ''
      end
    end

    context 'with partial address informations' do
      let(:profile) { build :profile, city: 'paris', country: 'france'}

      it 'returns correct address' do
        expect(tested_method).to eq 'paris, france'
      end
    end

    context 'with full address informations' do
      let(:profile) { build :profile, stree: '9 rue des mimosas', zipcode: '09140', city: 'le vernet', country: 'france'}

      it 'returns correct address' do
        expect(tested_method).to eq '9 rue des mimosas, 09140, le vernet, france'
      end
    end
  end
end
