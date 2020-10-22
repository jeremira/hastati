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
    expect(page).to have_content 'lunch 06/05/2020'
    expect(page).to have_content "Hosted by #{host.email}, up to 2 people."
    select 2, from: :booking_people
    expect do
      click_button 'Confirm booking'
    end.to change(Booking, :count).from(0).to 1
    expect(page).to have_content 'Event has been booked.'
    expect(page).to have_content '@Maisons-Laffite for 2 people'
    expect(page).to have_content '06/05/2020 for lunch'
    expect(page).to have_content 'Hosted by : Babar bouba'
    visit '/events'
    expect(page).to have_content 'Available events : 0'
  end

  it 'A guest cant book an already booked event' do
    slot = create :slot, user: host, status: 1, scheduled_at: '2020/05/06'
    sign_in guest
    visit '/events'
    expect(page).to have_content 'Available events : 0'
    visit "/bookings/new?booking[slot_id]=#{slot.id}"
    expect(page).to have_content 'lunch 06/05/2020'
    expect(page).to have_content "Hosted by #{host.email}, up to 2 people."
    select 1, from: :booking_people
    expect do
      click_button 'Confirm booking'
    end.not_to change(Booking, :count)
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
    expect(page).not_to have_content '07/05/2020 for lunch'
    click_link 'Book event'
    expect(page).to have_content 'lunch 06/05/2020'
    expect(page).to have_content "Hosted by #{other_host.email}, up to 2 people."
    select 2, from: :booking_people
    expect do
      click_button 'Confirm booking'
    end.to change(Booking, :count).from(0).to 1
    expect(page).to have_content 'Event has been booked.'
    expect(page).to have_content '@Maisons-Laffite for 2 people'
    expect(page).to have_content '06/05/2020 for lunch'
    expect(page).to have_content 'Hosted by : Babar bouba'
    visit '/events'
    expect(page).to have_content 'Available events : 0'
  end

  it 'An host cant book his own event' do
    slot = create :slot, user: host, status: 0, scheduled_at: '2020/05/06'
    sign_in host
    visit '/events'
    expect(page).to have_content 'Available events : 0'
    visit "/bookings/new?booking[slot_id]=#{slot.id}"
    expect(page).to have_content 'lunch 06/05/2020'
    expect(page).to have_content "Hosted by #{host.email}, up to 2 people."
    select 1, from: :booking_people
    expect do
      click_button 'Confirm booking'
    end.not_to change(Booking, :count)
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
    expect(page).to have_content 'lunch 06/05/2020'
    expect(page).to have_content "Hosted by #{other_host.email}, up to 2 people."
    select 1, from: :booking_people
    expect do
      click_button 'Confirm booking'
    end.not_to change(Booking, :count)
    expect(page).to have_content 'Event could not be booked.'
    expect(page).to have_content 'Available events : 0'
  end
end
