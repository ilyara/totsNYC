class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :nick
      t.references :role

      t.timestamps
    end
    add_index :people, :role_id
  end
end
