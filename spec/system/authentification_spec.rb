# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentification' do
  let(:admin) { create :admin_user, email: 'admin@test.fr', password: 'Abcd1234', password_confirmation: 'Abcd1234' }
  let(:user) { create :user, email: 'user@test.fr', password: 'Abcd1234', password_confirmation: 'Abcd1234' }

  context 'with an Admin user' do
    it 'can access Admin dashboard' do
      admin
      visit '/admin'
      fill_in :admin_user_email, with: 'admin@test.fr'
      fill_in :admin_user_password, with: 'Abcd1234'
      click_button 'Login'
      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_content 'Hastati Admin Dashboard'
    end
    it 'can not access Root page' do
      admin
      visit '/'
      fill_in :user_email, with: 'admin@test.fr'
      fill_in :user_password, with: 'Abcd1234'
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end
  end

  context 'with an user' do
    it 'can not access Admin dashboard' do
      user
      visit '/admin'
      fill_in :admin_user_email, with: 'user@test.fr'
      fill_in :admin_user_password, with: 'Abcd1234'
      click_button 'Login'
      expect(page).to have_content 'Invalid Email or password.'
    end
    it 'can not access Root page' do
      user
      visit '/'
      fill_in :user_email, with: 'user@test.fr'
      fill_in :user_password, with: 'Abcd1234'
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_content user.email
    end
  end
end
