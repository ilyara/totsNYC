class CreateManagers < ActiveRecord::Migration
  def self.up
    create_table :managers do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :managers
  end
end
