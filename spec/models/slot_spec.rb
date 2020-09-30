# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Slot, type: :model do
  let(:slot) { build :slot }

  it 'has a valid factory' do
    expect(slot).to be_valid
  end
end
