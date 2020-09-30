# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  # Active admin routing
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Devise Authentification routing
  devise_for :users

  resources :slots, only: [:index, :create]
end
