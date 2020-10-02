# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Root page', type: :system do
  let(:guest) { create :guest_user }
  let(:host) { create :host_user }

  it 'A logged-in guest sees the events page' do
    sign_in guest
    visit '/'
    expect(page).to have_content 'Available events : 0'
  end

  it 'A logged-in host sees the slots page' do
    sign_in host
    visit '/'
    expect(page).to have_content 'Available events : 0'
  end
end
