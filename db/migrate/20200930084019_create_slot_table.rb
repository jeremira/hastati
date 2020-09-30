class CreateSlotTable < ActiveRecord::Migration[6.0]
  def change
    create_table :slots do |table|
      table.integer :status, default: 0, null: false
      table.datetime :scheduled_at, null: false
      table.integer :daytime
      table.integer :max_people
      table.references :user

      table.timestamps
    end
  end
end
