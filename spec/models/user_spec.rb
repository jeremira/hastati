# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build :guest_user }

  describe 'Validation' do
    it 'has a valid factory' do
      expect(user).to be_valid
    end
    it 'requires an email' do
      expect(build(:guest_user, email: nil)).not_to be_valid
    end
    it 'requires an unic email' do
      create :host_user, email: user.email
      expect(user).not_to be_valid
    end
    it 'is a guest by default' do
      expect(user.guest?).to be true
    end
    it 'becomes an host' do
      user.host!
      expect(user.host?).to be true
    end
  end
end
