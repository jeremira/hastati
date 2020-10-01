# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentification' do
  let(:admin) { create :admin_user }
  let(:guest) { create :guest_user }
  let(:host) { create :host_user }

  context 'with an Admin user' do
    it 'can access Admin dashboard' do
      admin
      visit '/admin'
      fill_in :admin_user_email, with: admin.email
      fill_in :admin_user_password, with: 'Abcd1234'
      click_button 'Login'
      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_content 'Hastati Admin Dashboard'
    end
    it 'can not access Root page' do
      admin
      visit '/'
      fill_in :user_email, with: admin.email
      fill_in :user_password, with: 'Abcd1234'
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end
  end

  context 'with a guest' do
    it 'can not access Admin dashboard' do
      guest
      visit '/admin'
      fill_in :admin_user_email, with: guest.email
      fill_in :admin_user_password, with: 'Abcd1234'
      click_button 'Login'
      expect(page).to have_content 'Invalid Email or password.'
    end
    it 'can access Root page' do
      guest
      visit '/'
      fill_in :user_email, with: guest.email
      fill_in :user_password, with: 'Abcd1234'
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully.'
    end
  end

  context 'with an host' do
    it 'can not access Admin dashboard' do
      host
      visit '/admin'
      fill_in :admin_user_email, with: host.email
      fill_in :admin_user_password, with: 'Abcd1234'
      click_button 'Login'
      expect(page).to have_content 'Invalid Email or password.'
    end
    it 'can access Root page' do
      host
      visit '/'
      fill_in :user_email, with: host.email
      fill_in :user_password, with: 'Abcd1234'
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully.'
    end
  end
end
