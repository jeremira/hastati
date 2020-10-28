class CreateProfileTable < ActiveRecord::Migration[6.0]
  def change
    create_table :profile_tables do |t|
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
