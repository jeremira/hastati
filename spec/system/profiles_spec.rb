# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profile', type: :system do
  let(:host) { create :host_user }
  let(:guest) { create :guest_user }

  it 'A guest fill in his profile' do
    sign_in guest
    visit '/profile'
    expect(page).to have_content 'Account informations'
    expect(page).to have_content "Email : #{guest.email}"
    expect(page).to have_content 'Full name :'
    expect(page).to have_content 'Address :'
    click_link 'Edit my informations'
    expect(page).to have_content 'Account informations'
    fill_in :profile_firstname, with: 'Patrick'
    fill_in :profile_lastname, with: 'Bernard'
    fill_in :profile_street, with: '9 rue des Mimosas'
    fill_in :profile_zipcode, with: '31810'
    fill_in :profile_city, with: 'Le Vernet'
    fill_in :profile_country, with: 'france'
    expect do
      click_button 'Save informations'
    end.not_to change(Profile, :count)
    expect(page).to have_content 'Account information saved.'
    expect(Profile.where(
             user_id: guest.id, street: '9 rue des mimosas', lastname: 'bernard',
             firstname: 'patrick', zipcode: '31810', city: 'le vernet', country: 'france'
           )).not_to be nil
    expect(page).to have_content 'Account informations'
    expect(page).to have_content "Email : #{guest.email}"
    expect(page).to have_content 'Full name : Patrick Bernard'
    expect(page).to have_content 'Address : 9 rue des mimosas, 31810, le vernet, france'
    click_link 'Edit my informations'
    fill_in :profile_city, with: 'Venerque'
    expect do
      click_button 'Save informations'
    end.not_to change(Profile, :count)
    expect(page).to have_content 'Account information saved.'
    expect(Profile.where(
             user_id: guest.id, street: '9 rue des mimosas', lastname: 'bernard',
             firstname: 'patrick', zipcode: '31810', city: 'venerque', country: 'france'
           )).not_to be nil
    expect(page).to have_content 'Account informations'
    expect(page).to have_content "Email : #{guest.email}"
    expect(page).to have_content 'Full name : Patrick Bernard'
    expect(page).to have_content 'Address : 9 rue des mimosas, 31810, venerque, france'
  end
  it 'An host fill in his profile' do
    sign_in host
    visit '/profile'
    expect(page).to have_content 'Account informations'
    expect(page).to have_content "Email : #{host.email}"
    expect(page).to have_content 'Full name '
    expect(page).to have_content 'Address :'
    click_link 'Edit my informations'
    expect(page).to have_content 'Account informations'
    fill_in :profile_firstname, with: 'Patrick'
    fill_in :profile_lastname, with: 'Bernard'
    fill_in :profile_street, with: '9 rue des Mimosas'
    fill_in :profile_zipcode, with: '31810'
    fill_in :profile_city, with: 'Le Vernet'
    fill_in :profile_country, with: 'france'
    expect do
      click_button 'Save informations'
    end.not_to change(Profile, :count)
    expect(page).to have_content 'Account information saved.'
    expect(Profile.where(
             user_id: host.id, street: '9 rue des mimosas', lastname: 'bernard',
             firstname: 'patrick', zipcode: '31810', city: 'le vernet', country: 'france'
           )).not_to be nil
    expect(page).to have_content 'Account informations'
    expect(page).to have_content "Email : #{host.email}"
    expect(page).to have_content 'Full name : Patrick Bernard'
    expect(page).to have_content 'Address : 9 rue des mimosas, 31810, le vernet, france'
    click_link 'Edit my informations'
    fill_in :profile_city, with: 'Venerque'
    expect do
      click_button 'Save informations'
    end.not_to change(Profile, :count)
    expect(page).to have_content 'Account information saved.'
    expect(Profile.where(
             user_id: guest.id, street: '9 rue des mimosas', lastname: 'bernard',
             firstname: 'patrick', zipcode: '31810', city: 'venerque', country: 'france'
           )).not_to be nil
    expect(page).to have_content 'Account informations'
    expect(page).to have_content "Email : #{host.email}"
    expect(page).to have_content 'Full name : Patrick Bernard'
    expect(page).to have_content 'Address : 9 rue des mimosas, 31810, venerque, france'
  end
end
