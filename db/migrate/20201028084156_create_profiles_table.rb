class CreateProfilesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.string :firstname
      t.string :lastname
      t.string :street
      t.string :zipcode
      t.string :city
      t.string :country
    end
  end
end
