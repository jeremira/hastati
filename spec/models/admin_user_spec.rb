# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  let(:admin) { build :admin_user }

  it 'has a valid factory' do
    expect(admin).to be_valid
  end
end
