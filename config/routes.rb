# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'events#index'

  # Active admin routing
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Devise Authentification routing
  devise_for :users

  resource :profile, only: [:show, :edit, :update]
  resources :events, only: [:index]
  resources :bookings, only: [:index, :new, :create]

  namespace :host do
    resources :slots, only: [:index, :create]
  end
  namespace :guest do
  end
end
