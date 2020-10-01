# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Slots', type: :system do
  let(:user) { create :host_user }

  it 'A Host create his first slot' do
    sign_in user
    visit '/'
    expect(page).to have_content "Slots for #{user.email} : 0"
    fill_in :slot_scheduled_at, with: '05/05/2020'
    select 'lunch', from: :slot_daytime
    select 2, from: :slot_max_people
    click_button 'Create slot'
    expect(page).to have_content 'Slot created'
    expect(page).to have_content "Slots for #{user.email} : 1"
    expect(page).to have_content 'Available - 05/05/2020 - Lunch - 2 ppl max'
  end

  it 'A host consults all his slots' do
    create :slot, user: user, status: 0, scheduled_at: '2020/05/05'
    create :slot, user: user, status: 0, scheduled_at: '2020/05/05', daytime: 1
    create :slot, user: user, status: 1, scheduled_at: '2020/05/05', max_people: 4
    create :slot, user: user, status: 2, scheduled_at: '2020/05/05', daytime: 1, max_people: 10
    sign_in user
    visit '/'
    expect(page).to have_content "Slots for #{user.email} : 4"
    expect(page).to have_content 'Available - 05/05/2020 - Lunch - 2 ppl max'
    expect(page).to have_content 'Available - 05/05/2020 - Dinner - 2 ppl max'
    expect(page).to have_content 'Booked - 05/05/2020 - Lunch - 4 ppl max'
    expect(page).to have_content 'Payed - 05/05/2020 - Dinner - 10 ppl max'
  end
end
