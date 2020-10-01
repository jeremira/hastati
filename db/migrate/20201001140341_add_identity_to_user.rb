class AddIdentityToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :identity, :integer, default: 0, null: false

    User.update_all(identity: 0)
  end
end
