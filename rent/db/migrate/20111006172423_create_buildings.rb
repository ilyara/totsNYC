class CreateBuildings < ActiveRecord::Migration
  def self.up
    create_table :buildings do |t|
      t.string :address
      t.references :company
      t.timestamps
    end
  end

  def self.down
    drop_table :buildings
  end
end
