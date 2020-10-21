# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bookings', type: :system do
  let(:frozen_time) { Time.zone.parse '2020/02/03' }
  let(:host) { create :host_user }
  let(:guest) { create :guest_user }

  before do
    allow(Time).to receive(:now).and_return(frozen_time)
  end

  it 'A guest book an available event' do
    create :slot, user: host, status: 0, scheduled_at: '2020/05/06'
    sign_in guest
    visit '/events'
    expect(page).to have_content 'Available events : 1'
    click_link 'Book event'
    expect(page).to have_content 'Do you want to book this event ?'
    expect(page).to have_content "Available - #{host.email} - 06/05/2020 - Lunch - 2 ppl max"
    select 2, from: :booking_people
    click_button 'Confirm booking'
    expect(page).to have_content 'Event has been booked.'
    expect(page).to have_content 'My bookings :'
    expect(page).to have_content "Booked - #{host.email} - 06/05/2020 - Lunch - 2 ppl"
    visit '/events'
    expect(page).to have_content 'Available events : 0'
  end

  it 'A guest cant book an already booked event' do
    slot = create :slot, user: host, status: 1, scheduled_at: '2020/05/06'
    sign_in guest
    visit '/events'
    expect(page).to have_content 'Available events : 0'
    visit "/bookings/new?booking[slot_id]=#{slot.id}"
    expect(page).to have_content 'Do you want to book this event ?'
    expect(page).to have_content "Booked - #{host.email} - 06/05/2020 - Lunch - 2 ppl max"
    select 1, from: :booking_people
    click_button 'Confirm booking'
    expect(page).to have_content 'Event could not be booked.'
    expect(page).to have_content 'Available events : 0'
  end

  it 'An host can book other host event' do
    other_host = create :host_user
    create :slot, user: host, status: 0, scheduled_at: '2020/05/07'
    create :slot, user: other_host, status: 0, scheduled_at: '2020/05/06'
    sign_in host
    visit '/events'
    expect(page).to have_content 'Available events : 1'
    expect(page).not_to have_content "Available - #{host.email} - 07/05/2020 - Lunch - 2 ppl max"
    click_link 'Book event'
    expect(page).to have_content 'Do you want to book this event ?'
    expect(page).to have_content "Available - #{other_host.email} - 06/05/2020 - Lunch - 2 ppl max"
    select 2, from: :booking_people
    click_button 'Confirm booking'
    expect(page).to have_content 'Event has been booked.'
    expect(page).to have_content 'My bookings :'
    expect(page).to have_content "Booked - #{other_host.email} - 06/05/2020 - Lunch - 2 ppl"
    visit '/events'
    expect(page).to have_content 'Available events : 0'
  end

  it 'An host cant book his own event' do
    slot = create :slot, user: host, status: 0, scheduled_at: '2020/05/06'
    sign_in host
    visit '/events'
    expect(page).to have_content 'Available events : 0'
    visit "/bookings/new?booking[slot_id]=#{slot.id}"
    expect(page).to have_content 'Do you want to book this event ?'
    expect(page).to have_content "Available - #{host.email} - 06/05/2020 - Lunch - 2 ppl max"
    select 1, from: :booking_people
    click_button 'Confirm booking'
    expect(page).to have_content 'Event could not be booked.'
    expect(page).to have_content 'Available events : 0'
  end

  it 'An host cant book an already booked event' do
    other_host = create :host_user
    slot = create :slot, user: other_host, status: 1, scheduled_at: '2020/05/06'
    sign_in host
    visit '/events'
    expect(page).to have_content 'Available events : 0'
    visit "/bookings/new?booking[slot_id]=#{slot.id}"
    expect(page).to have_content 'Do you want to book this event ?'
    expect(page).to have_content "Booked - #{other_host.email} - 06/05/2020 - Lunch - 2 ppl max"
    select 1, from: :booking_people
    click_button 'Confirm booking'
    expect(page).to have_content 'Event could not be booked.'
    expect(page).to have_content 'Available events : 0'
  end
end
