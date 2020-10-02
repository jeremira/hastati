# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events', type: :system do
  let(:frozen_time) { Time.zone.parse('2020/05/05') }
  let(:host) { create :host_user }
  let(:host2) { create :host_user }
  let(:guest) { create :guest_user }

  before do
    allow(Time).to receive(:now).and_return(frozen_time)
  end

  it 'A guest see no events' do
    sign_in guest
    visit '/'
    expect(page).to have_content 'Available events : 0'
  end
  it 'A guest see available events' do
    # Available futur events
    create :slot, user: host, status: 0, scheduled_at: '2020/05/06'
    create :slot, user: host, status: 0, scheduled_at: '2020/06/02'
    create :slot, user: host2, status: 0, scheduled_at: '2020/05/09'
    # Available past events
    create :slot, user: host, status: 0, scheduled_at: '2020/04/05'
    create :slot, user: host2, status: 0, scheduled_at: '2020/05/04'
    # Non-available events
    create :slot, user: host, status: 1, scheduled_at: '2020/04/05'
    create :slot, user: host, status: 1, scheduled_at: '2020/06/05'
    create :slot, user: host2, status: 1, scheduled_at: '2020/06/05'
    create :slot, user: host, status: 2, scheduled_at: '2020/06/05'
    sign_in guest
    visit '/'
    expect(page).to have_content 'Available events : 3'
    expect(page).to have_content "Available - #{host.email} - 06/05/2020 - Lunch - 2 ppl max"
    expect(page).to have_content "Available - #{host.email} - 02/06/2020 - Lunch - 2 ppl max"
    expect(page).to have_content "Available - #{host2.email} - 09/05/2020 - Lunch - 2 ppl max"
    expect(page).not_to have_content 'Booked'
    expect(page).not_to have_content 'Payed'
  end
end
