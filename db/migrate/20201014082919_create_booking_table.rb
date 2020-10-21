class CreateBookingTable < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |table|
      table.integer :people
      table.references :slot
      table.references :user

      table.timestamps
    end
  end
end
