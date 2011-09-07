class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.references :playdate
      t.references :person

      t.timestamps
    end
    add_index :signups, :playdate_id
    add_index :signups, :person_id
  end
end
