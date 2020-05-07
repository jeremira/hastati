# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |table|
      ## Database authenticatable
      table.string :email,              null: false, default: ''
      table.string :encrypted_password, null: false, default: ''

      ## Recoverable
      table.string   :reset_password_token
      table.datetime :reset_password_sent_at

      ## Rememberable
      table.datetime :remember_created_at

      ## Trackable
      # table.integer  :sign_in_count, default: 0, null: false
      # table.datetime :current_sign_in_at
      # table.datetime :last_sign_in_at
      # table.inet     :current_sign_in_ip
      # table.inet     :last_sign_in_ip

      ## Confirmable
      # table.string   :confirmation_token
      # table.datetime :confirmed_at
      # table.datetime :confirmation_sent_at
      # table.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # table.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # table.string   :unlock_token # Only if unlock strategy is :email or :both
      # table.datetime :locked_at

      table.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
