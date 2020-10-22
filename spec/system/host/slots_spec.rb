# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Slots', type: :system do
  let(:host) { create :host_user }
  let(:guest) { create :guest_user }

  it 'A Host create his first slot' do
    sign_in host
    visit '/host/slots'
    expect(page).to have_content 'Organize your availabilities'
    fill_in :slot_scheduled_at, with: '05/05/2020'
    select 'lunch', from: :slot_daytime
    select 2, from: :slot_max_people
    expect do
      click_button 'Create slot'
    end.to change(Slot, :count).from(0).to 1
    expect(page).to have_content 'Slot created'
    expect(page).to have_content '@Maisons-Laffite up to 2 people'
    expect(page).to have_content '05/05/2020 for lunch'
    expect(page).to have_content 'Slot status : available'
  end

  it 'A host consults all his slots' do
    slot1 = create :slot, user: host, status: 0, scheduled_at: '2020/05/05'
    slot2 = create :slot, user: host, status: 0, scheduled_at: '2020/05/05', daytime: 1
    slot3 = create :slot, user: host, status: 1, scheduled_at: '2020/05/05', max_people: 4
    slot4 = create :slot, user: host, status: 2, scheduled_at: '2020/05/05', daytime: 1, max_people: 10
    sign_in host
    visit '/host/slots'
    within "#slot-card-#{slot1.id}" do
      expect(page).to have_content '@Maisons-Laffite up to 2 people'
      expect(page).to have_content '05/05/2020 for lunch'
      expect(page).to have_content 'Slot status : available'
    end
    within "#slot-card-#{slot2.id}" do
      expect(page).to have_content '@Maisons-Laffite up to 2 people'
      expect(page).to have_content '05/05/2020 for dinner'
      expect(page).to have_content 'Slot status : available'
    end
    within "#slot-card-#{slot3.id}" do
      expect(page).to have_content '@Maisons-Laffite up to 4 people'
      expect(page).to have_content '05/05/2020 for lunch'
      expect(page).to have_content 'Slot status : booked'
    end
    within "#slot-card-#{slot4.id}" do
      expect(page).to have_content '@Maisons-Laffite up to 10 people'
      expect(page).to have_content '05/05/2020 for dinner'
      expect(page).to have_content 'Slot status : payed'
    end
  end

  it 'A guest can not access slots page' do
    sign_in guest
    visit '/host/slots'
    expect(page).to have_content 'You can not access this page.'
  end
end
